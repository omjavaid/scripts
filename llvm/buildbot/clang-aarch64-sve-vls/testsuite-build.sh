#!/bin/bash
set -euo pipefail

# Paths relative to the build directory (the directory you run this script from)
LLVM_INSTALL_DIR="$(pwd)/../stage1.install"
LIT_BIN="$(pwd)/../stage1/bin/llvm-lit"
TEST_SUITE_SRC_DIR="../llvm-test-suite"

# SVE/CPU flags
SVE_FLAGS="-mcpu=neoverse-512tvb -msve-vector-bits=256 -mllvm -treat-scalable-fixed-error-as-warning=false -O3"

# Set compilers
export CC="$LLVM_INSTALL_DIR/bin/clang"
export CXX="$LLVM_INSTALL_DIR/bin/clang++"
export FC="$LLVM_INSTALL_DIR/bin/flang"

# CMake configure step (in this build dir, using ../llvm-test-suite as source)
cmake -G Ninja "$TEST_SUITE_SRC_DIR" \
  -DTEST_SUITE_FORTRAN=ON \
  -DTEST_SUITE_COLLECT_CODE_SIZE=OFF \
  -DTEST_SUITE_LIT="$LIT_BIN" \
  -DTEST_SUITE_SUBDIRS="Fortran" \
  -DCMAKE_C_FLAGS="$SVE_FLAGS" \
  -DCMAKE_CXX_FLAGS="$SVE_FLAGS" \
  -DCMAKE_Fortran_FLAGS="$SVE_FLAGS"

# Build the test suite
#ninja

echo "Build completed! To run tests:"
echo "  NO_STOP_MESSAGE=1 ninja check"

