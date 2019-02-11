mkdir -p build/android-arm64 && cd build/android-arm64 && rm -rf *
cmake -G Ninja ../../llvm \
-DCMAKE_TOOLCHAIN_FILE=../../llvm/tools/lldb/cmake/platforms/Android.cmake \
-DANDROID_TOOLCHAIN_DIR=/home/omair/work/toolchains/arm64-android-toolchain \
-DANDROID_ABI=aarch64 \
-DCMAKE_CXX_COMPILER_VERSION=4.9 \
-DLLVM_TARGET_ARCH=aarch64 \
-DLLVM_TARGETS_TO_BUILD=AArch64 \
-DLLVM_HOST_TRIPLE=aarch64-unknown-linux-android \
-DLLVM_TABLEGEN=$PWD/../host/bin/llvm-tblgen \
-DCLANG_TABLEGEN=$PWD/../host/bin/clang-tblgen \
-DCMAKE_BUILD_TYPE=$1
ninja lldb-server
