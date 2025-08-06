#!/bin/bash

if [ -z "$(pwd)" ]; then
  echo "Build directory not empty..."
  exit
fi

LLVM_SRC_DIR=$(pwd)/../llvm-project

if [ ! -d $LLVM_SRC_DIR ]; then
  echo "LLVM source directory not found..."
  exit
fi

cmake -G Ninja \
-DCMAKE_BUILD_TYPE=Release \
-DLLVM_ENABLE_ASSERTIONS=True \
-DCMAKE_INSTALL_PREFIX=../stage1.install \
-DLLVM_LIT_ARGS="-v" \
-DLLVM_ENABLE_PROJECTS="llvm;clang;clang-tools-extra" \
-DLLVM_PARALLEL_LINK_JOBS=4 \
$LLVM_SRC_DIR/llvm
