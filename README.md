# Setup
Clone recursively:

    git clone --recursive https://github.com/because-why-not/webrtc_visionpro_workspace

The customised webrtc source code will be cloned to the subfolder `src`. The build toolchain had to be customised as well. You find it at `src/build`

# Testing
After cloning run `./setup_xros.sh` to create the gn project. This will also run `gclient sync` for you to download the third party dependencies. It will take a long time!

After this completed run `./build_xros.sh` to build the WebRTC.framekwork for both the simulator and the device.

You find the output at:

    ./src/out/simxros-arm64-debug/WebRTC.framework
    ./src/out/xros-arm64-debug/WebRTC.framework

Check out the contents of the .sh files for details. If you use a custom XCode installtion you can set this via the env.sh or the environment variable XCODE_PATH.

The build will use the iOS toolchain of WebRTC but changes the SDK to xros, uses the clang version of xcode and customises some compiler flags. 
My own test project does run in the vision pro emulator but I do not have an actual device for testing. 

If you have a vision pro please try the WebRTC.framework in your own project and let us know the results!

