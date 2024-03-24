set -e
XC_NAME="webrtc.xcframework"
echo "This script merges mac, ios and xros into ${XC_NAME} and patches the xros plist files"
rm -r ${XC_NAME} > /dev/null 2>&1 || true
mkdir ${XC_NAME}
mkdir -p ./${XC_NAME}/ios-arm64
mkdir -p ./${XC_NAME}/xros-arm64
mkdir -p ./${XC_NAME}/simxros-arm64
mkdir -p ./${XC_NAME}/mac-arm64

cp -R ./src/out/ios-arm64-debug/WebRTC.framework ./${XC_NAME}/ios-arm64
cp -R ./src/out/xros-arm64-debug/WebRTC.framework ./${XC_NAME}/xros-arm64
cp -R ./src/out/simxros-arm64-debug/WebRTC.framework ./${XC_NAME}/simxros-arm64
cp -R ./src/out/mac-arm64-debug/WebRTC.framework ./${XC_NAME}/mac-arm64

cp plist/Info.plist ./${XC_NAME}
echo "Fixing plist"
#rm ./${XC_NAME}/simxros-arm64/Info.plist
#rm ./${XC_NAME}/xros-arm64/Info.plist
cp ./plist/simxros-arm64/Info.plist ./${XC_NAME}/simxros-arm64/WebRTC.framework
cp ./plist/xros-arm64/Info.plist ./${XC_NAME}/xros-arm64/WebRTC.framework/Info.plist
