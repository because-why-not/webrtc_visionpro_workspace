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
gn gen out/mac-x64-debug --args='target_os="mac" target_cpu="x64" is_component_build=false is_debug=true   enable_dsyms=true use_custom_libcxx=false' --ide=xcode
gn gen out/mac-x64-release --args='target_os="mac" target_cpu="x64" is_component_build=false is_debug=false  use_custom_libcxx=false' --ide=xcode
gn gen out/mac-arm64-debug --args='target_os="mac" target_cpu="arm64" is_component_build=false is_debug=true   enable_dsyms=true use_custom_libcxx=false' --ide=xcode
gn gen out/mac-arm64-release --args='target_os="mac" target_cpu="arm64" is_component_build=false is_debug=false  use_custom_libcxx=false' --ide=xcode
gn gen out/ios-arm64-debug   --args='target_os="ios" target_cpu="arm64" is_component_build=false is_debug=true ios_enable_code_signing=false use_custom_libcxx=false enable_dsyms=true  rtc_include_tests=false' --ide=xcode
gn gen out/ios-arm64-release --args='target_os="ios" target_cpu="arm64" is_component_build=false is_debug=false ios_enable_code_signing=false use_custom_libcxx=false rtc_include_tests=false' --ide=xcode