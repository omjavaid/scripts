mkdir -p build/android-arm32 && cd build/android-arm32 && rm -rf *
cmake -G Ninja ../../llvm \
-DCMAKE_TOOLCHAIN_FILE=../../llvm/tools/lldb/cmake/platforms/Android.cmake \
-DANDROID_TOOLCHAIN_DIR=/home/omair/work/toolchains/arm32-android-toolchain \
-DANDROID_ABI=armeabi \
-DLLVM_TARGETS_TO_BUILD=ARM \
-DLLVM_HOST_TRIPLE=arm-unknown-linux-android \
-DLLVM_TABLEGEN=$PWD/../host/bin/llvm-tblgen \
-DCLANG_TABLEGEN=$PWD/../host/bin/clang-tblgen \
-DCMAKE_BUILD_TYPE=Debug
ninja lldb-server
