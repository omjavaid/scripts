#!/bin/bash

BUILD_TYPE=

if [ "$1" == "debug" ] ; then
  BUILD_TYPE=Debug
elif [ "$1" == "release" ] ; then
  BUILD_TYPE=Release
else
  exit
fi

# TODO: Give user option to do a clean build or exit
rm -rf ./*

LLVM_SRC_DIR=../../llvm-project

#In order to build the documentation need to add -DLLVM_ENABLE_SPHINX=ON.
#Once you do this you can build the docs using docs-lld-html build (ninja or make) target.

# This script uses system compiler set to /usr/local/bin/cc == ccache clang 
cmake -G Ninja \
-DCMAKE_BUILD_TYPE=$BUILD_TYPE \
-DCMAKE_INSTALL_PREFIX=../install \
-DLLVM_ENABLE_PROJECTS="lld;lldb;clang" \
-DLLVM_USE_LINKER=lld \
-DCLANG_DEFAULT_LINKER=lld \
-DLLVM_ENABLE_ASSERTIONS=True \
-DLLVM_LIT_ARGS="-svj 8" \
-DLLVM_PARALLEL_LINK_JOBS=4 \
$LLVM_SRC_DIR/llvm

ninja

