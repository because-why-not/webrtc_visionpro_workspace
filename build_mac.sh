set -v
set -e
#ensure webrtc folder has its dependencies in sync with the git checkout
./sync.sh
ownpath="$(dirname $0)/src"
pushd ${ownpath}
ninja -C out/mac-x64-debug webrtc
ninja -C out/mac-x64-release webrtc
ninja -C out/mac-arm64-debug webrtc
ninja -C out/mac-arm64-release webrtc
ninja -C out/ios-arm64-debug webrtc
ninja -C out/ios-arm64-release webrtc
#ninja -C out/ios-arm-debug webrtc && ninja -C out/ios-arm-release webrtc

popd

        
