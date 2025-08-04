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
-DCMAKE_C_FLAGS="-mcpu=neoverse-512tvb" \
-DCMAKE_CXX_FLAGS="-mcpu=neoverse-512tvb" \
-DLLVM_ENABLE_LLD=True \
-DMLIR_INCLUDE_INTEGRATION_TESTS=True \
-DMLIR_RUN_ARM_SVE_TESTS=True \
-DLLVM_ENABLE_PROJECTS="llvm;mlir;flang;clang;lld;clang-tools-extra" \
-DLLVM_ENABLE_RUNTIMES="flang-rt;compiler-rt" \
-DLLVM_PARALLEL_LINK_JOBS=4 \
$LLVM_SRC_DIR/llvm
