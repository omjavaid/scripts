#!/bin/bash

BUILD_TYPE=${1,,}

if [ "$BUILD_TYPE" == "debug" ] ; then
  BUILD_TYPE=Debug
else
  BUILD_TYPE=Release
fi

echo "$BUILD_TYPE build selected..."

if [ -z "$(pwd)" ]; then
  echo "Build directory not empty..."
  exit
fi

LLVM_SRC_DIR=$(pwd)/../llvm-project

if [ ! -d $LLVM_SRC_DIR ]; then
  echo "LLVM source directory not found..."
  exit
fi

# TODO: Give user option to do a clean build or exit
#rm -rf ./*

#In order to build the documentation need to add -DLLVM_ENABLE_SPHINX=ON.
#Once you do this you can build the docs using docs-lld-html build (ninja or make) target.
#-DCMAKE_INSTALL_PREFIX=../install 
# This script uses system compiler set to /usr/local/bin/cc == ccache clang 
#-DLLVM_USE_LINKER=gold 
#-DCMAKE_C_COMPILER=clang
#-DCMAKE_CXX_COMPILER=clang++
#-DCMAKE_C_COMPILER_LAUNCHER=ccache
#-DCMAKE_CXX_COMPILER_LAUNCHER=ccache

cmake -G Ninja \
-DCMAKE_BUILD_TYPE=$BUILD_TYPE \
-DLLVM_ENABLE_PROJECTS="lld;lldb;clang" \
-DLLVM_USE_LINKER=lld \
-DCLANG_DEFAULT_LINKER=lld \
-DLLVM_ENABLE_ASSERTIONS=True \
-DLLVM_LIT_ARGS="-svj 8" \
-DLLVM_PARALLEL_LINK_JOBS=4 \
$LLVM_SRC_DIR/llvm
