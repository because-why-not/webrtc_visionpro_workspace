set -e
#we create a link to either the debug or release build in the end which
#is used by the test project
#set to debug or release to pick which one is used
USE_CONFIG="release"
#remove link we use for our test project
rm -rf webrtc.xcframework > /dev/null 2>&1 || true

for config in "debug" "release"; do
    XC_NAME="webrtc_$config.xcframework"
    echo "Merging mac, ios and xros into ${XC_NAME} and patches the xros plist files"
    #remove old build
    rm -r ${XC_NAME} > /dev/null 2>&1 || true

    #recreate folder structure
    mkdir ${XC_NAME}
    mkdir -p ./${XC_NAME}/ios-arm64
    mkdir -p ./${XC_NAME}/xros-arm64
    mkdir -p ./${XC_NAME}/simxros-arm64
    mkdir -p ./${XC_NAME}/mac-arm64

    #copy binaries into their folders
    cp -R ./src/out/ios-arm64-$config/WebRTC.framework ./${XC_NAME}/ios-arm64
    cp -R ./src/out/xros-arm64-$config/WebRTC.framework ./${XC_NAME}/xros-arm64
    cp -R ./src/out/simxros-arm64-$config/WebRTC.framework ./${XC_NAME}/simxros-arm64
    cp -R ./src/out/mac-arm64-$config/WebRTC.framework ./${XC_NAME}/mac-arm64

    #plist contains our folder structure needed for xcode to load it
    cp plist/Info.plist ./${XC_NAME}

    #our webrtc build still creates ios specific plists. We replace them with visionos versions
    echo "Fixing plist"
    cp ./plist/simxros-arm64/Info.plist ./${XC_NAME}/simxros-arm64/WebRTC.framework
    cp ./plist/xros-arm64/Info.plist ./${XC_NAME}/xros-arm64/WebRTC.framework/Info.plist
done


ln -s webrtc_${USE_CONFIG}.xcframework webrtc.xcframework