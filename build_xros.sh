set -v
set -e
#ensure webrtc folder has its dependencies in sync with the git checkout
./sync.sh

ninja -C src/out/simxros-arm64-debug customwebrtc
ninja -C src/out/xros-arm64-debug customwebrtc


        
