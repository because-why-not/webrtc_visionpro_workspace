set -e
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
#XCode 14.3
#for XCode 15: mac_deployment_target="10.14" mac_min_system_version="10.14" is needed for mac. iOS still has unresolved build issues
#related to __IPHONE_OS_VERSION_MIN_REQUIRED being undefined
gn gen out/mac-x64-debug --args='target_os="mac" target_cpu="x64" is_component_build=false is_debug=true   enable_dsyms=true use_custom_libcxx=false' --ide=xcode
gn gen out/mac-x64-release --args='target_os="mac" target_cpu="x64" is_component_build=false is_debug=false  use_custom_libcxx=false' --ide=xcode
gn gen out/mac-arm64-debug --args='target_os="mac" target_cpu="arm64" is_component_build=false is_debug=true   enable_dsyms=true use_custom_libcxx=false' --ide=xcode
gn gen out/mac-arm64-release --args='target_os="mac" target_cpu="arm64" is_component_build=false is_debug=false  use_custom_libcxx=false' --ide=xcode
gn gen out/ios-arm64-debug   --args='target_os="ios" target_cpu="arm64" is_component_build=false is_debug=true ios_enable_code_signing=false use_custom_libcxx=false enable_dsyms=true  rtc_include_tests=false' --ide=xcode
gn gen out/ios-arm64-release --args='target_os="ios" target_cpu="arm64" is_component_build=false is_debug=false ios_enable_code_signing=false use_custom_libcxx=false rtc_include_tests=false' --ide=xcode

PLATFORM_OUT_DIR=out/mac-x64-release
./tools_webrtc/libs/generate_licenses.py --target //:customwebrtc ${PLATFORM_OUT_DIR} ${PLATFORM_OUT_DIR}
PLATFORM_OUT_DIR=out/mac-arm64-release
./tools_webrtc/libs/generate_licenses.py --target //:customwebrtc ${PLATFORM_OUT_DIR} ${PLATFORM_OUT_DIR}
PLATFORM_OUT_DIR=out/ios-arm64-release
./tools_webrtc/libs/generate_licenses.py --target //:customwebrtc ${PLATFORM_OUT_DIR} ${PLATFORM_OUT_DIR}
popd