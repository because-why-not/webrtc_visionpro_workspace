set -e
source ./env.sh
gclient root
gclient config --spec 'solutions = [
  {
    "name": "src",
    "url": "https://webrtc.googlesource.com/src.git",
    "deps_file": "DEPS",
    "managed": False,
    "custom_deps": {},
  },
]
target_os = ["ios", "mac"]
'

ownpath="$(dirname $0)/src"
pushd ${ownpath}
gclient sync
echo "Using xcode from ${XCODE_PATH}"
gn gen out/simxros-arm64-debug   --args='
  target_os="ios"
  xros=true
  ios_target_override="arm64-apple-xros1.0-simulator"
  ios_sdk_override="'${XCODE_PATH}'/Contents/Developer/Platforms/XRSimulator.platform/Developer/SDKs/XRSimulator.sdk"
  target_cpu="arm64" 
  clang_base_path="'${XCODE_PATH}'/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/"
  is_component_build=false rtc_enable_objc_symbol_export=true 
  is_debug=true ios_enable_code_signing=false use_custom_libcxx=false enable_dsyms=true  rtc_include_tests=false clang_use_chrome_plugins = false use_lld=false ' --ide=xcode

gn gen out/xros-arm64-debug   --args='
  target_os="ios"
  xros=true
  ios_target_override="arm64-apple-xros1.0"
  ios_sdk_override="'${XCODE_PATH}'/Contents/Developer/Platforms/XROS.platform/Developer/SDKs/XROS1.0.sdk"
  target_cpu="arm64" 
  clang_base_path="'${XCODE_PATH}'/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/"
  is_component_build=false rtc_enable_objc_symbol_export=true 
  is_debug=true ios_enable_code_signing=false use_custom_libcxx=false enable_dsyms=true  rtc_include_tests=false clang_use_chrome_plugins = false use_lld=false ' --ide=xcode

popd