LLDB_HOST_TRIPLE=aarch64-linux-gnu
BUILD_ENV_TRIPLE=`gcc -dumpmachine`
GCC_INC=/usr/$LLDB_HOST_TRIPLE/include
GCC_V3=`gcc -dumpversion`
MARCH="-march=armv8-a+sve"
#MARCH="-march=armv8-a"
TARGET_C_FLAGS="-target $LLDB_HOST_TRIPLE $MARCH -I/$GCC_INC -I/$GCC_INC/c++/$GCC_V3/$LLDB_HOST_TRIPLE"
TARGET_CXX_FLAGS="$TARGET_C_FLAGS"
echo $TARGET_CXX_FLAGS
echo $TARGET_C_FLAGS
CLANG_EXE=/home/omair/work/lldb/lldb-dev/build/release/host/bin/clang
#CLANG_EXE=/home/omair/work/tools/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/clang++
$CLANG_EXE $TARGET_C_FLAGS $*
