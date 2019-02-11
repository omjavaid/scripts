cd build/host
ninja
cd ../..
# Change to arm-linux-gnueabi and build lldb-server
cd build/arm-linux-gnueabi
ninja lldb-server
cd ../..
# Change to arm-linux-gnueabihf and build lldb-server
cd build/arm-linux-gnueabihf
ninja lldb-server
cd ../..
# Change to aarch64-linux-gnu and build lldb-server
#cd build/aarch64-linux-gnu
#ninja lldb-server
#cd ../..
# Change to android-arm32 and build lldb-server
cd build/android-arm32
ninja lldb-server
cd ../..
# Change to android-arm64 and build lldb-server
#cd build/android-arm64
#ninja lldb-server
#cd ../..
