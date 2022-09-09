#!/bin/bash

# Install build dependencies:
# sudo apt install gcc-8-aarch64-linux-gnu
# sudo apt install g++-8-aarch64-linux-gnu

pushd .

cd /home/omair/work/lldb/lldb-dev/build

BUILD_TYPE=
if [ "$2" == "debug" ] ; then
  mkdir debug
  cd debug
  BUILD_TYPE=Debug
elif [ "$2" == "release" ] ; then
  mkdir release
  cd release
  BUILD_TYPE=Release
else
  exit
fi

LLDB_TARGET_ARCH=
if [ "$1" == "aarch64-linux-gnu" ] ; then
  LLDB_TARGET_ARCH=AArch64
  rm -rf ./$1
  mkdir $1
  cd $1
elif [ "$1" == "arm-linux-gnueabihf" ] ; then
  LLDB_TARGET_ARCH=ARM
  rm -rf ./$1
  mkdir $1
  cd $1
else
  exit
fi

C_COMPILER=clang
CXX_COMPILER=clang++

LLVM_SRC_DIR=/home/omair/work/lldb/lldb-dev/llvm-project

LLDB_HOST_TRIPLE=$1

LLVM_HOST_BUILD_DIR=../host

BUILD_ENV_TRIPLE=`gcc -dumpmachine`

GCC_INC=/usr/$LLDB_HOST_TRIPLE/include
#GCC_V3=`gcc --version | grep ^gcc | sed 's/^.* //g'`
GCC_V3=`gcc -dumpversion`
TARGET_C_FLAGS="-target $LLDB_HOST_TRIPLE -I/$GCC_INC -I/$GCC_INC/c++/$GCC_V3/$LLDB_HOST_TRIPLE"
TARGET_CXX_FLAGS="$TARGET_C_FLAGS"

cmake -G Ninja \
-DCMAKE_CROSSCOMPILING=1 \
-DCMAKE_C_COMPILER=$C_COMPILER \
-DCMAKE_CXX_COMPILER=$CXX_COMPILER \
-DCMAKE_C_FLAGS="$TARGET_C_FLAGS" \
-DCMAKE_CXX_FLAGS="$TARGET_CXX_FLAGS" \
-DCMAKE_C_COMPILER_LAUNCHER=ccache \
-DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
-DLLVM_USE_LINKER=gold \
-DLLVM_TABLEGEN=$LLVM_HOST_BUILD_DIR/bin/llvm-tblgen \
-DCLANG_TABLEGEN=$LLVM_HOST_BUILD_DIR/bin/clang-tblgen \
-DLLDB_TABLEGEN=$LLVM_HOST_BUILD_DIR/bin/lldb-tblgen \
-DLLVM_HOST_TRIPLE=$LLDB_HOST_TRIPLE \
-DLLVM_TARGETS_TO_BUILD=$LLDB_TARGET_ARCH \
-DLLVM_ENABLE_PROJECTS="clang;lldb" \
-DCMAKE_LIBRARY_ARCHITECTURE=$LLDB_HOST_TRIPLE \
-DCMAKE_IGNORE_PATH=/usr/lib/$BUILD_ENV_TRIPLE \
-DLLDB_TEST_COMPILER=$LLDB_HOST_TRIPLE-gcc \
-DLLDB_EXPORT_ALL_SYMBOLS=1 \
-DLLVM_ENABLE_ASSERTIONS=On \
-DCMAKE_BUILD_TYPE=$BUILD_TYPE \
-DLLDB_ENABLE_PYTHON=0 \
-DLLDB_ENABLE_LIBEDIT=0 \
-DLLDB_ENABLE_CURSES=0 \
-DLLVM_PARALLEL_LINK_JOBS=1 \
$LLVM_SRC_DIR/llvm

ninja lldb-server

popd
