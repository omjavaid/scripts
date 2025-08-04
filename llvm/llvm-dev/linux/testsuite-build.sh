#!/bin/bash

export CC=$HOME/work/llvm-dev/build/bin/clang-cl
export CXX=$HOME/work/llvm-dev/build/bin/clang-cl
export FC=$HOME/work/llvm-dev/build/bin/flang-new

#set NO_STOP_MESSAGE to 1 before running ninja check

cmake -G Ninja -DTEST_SUITE_FORTRAN=ON -DTEST_SUITE_COLLECT_CODE_SIZE=OFF -DTEST_SUITE_LIT=$HOME/work/llvm-dev/build/bin/llvm-lit.py -DTEST_SUITE_SUBDIRS="Fortran" ../llvm-test-suite

# Uncomment the following line if needed
# cmake -G Ninja -DCMAKE_C_COMPILER="/work/llvm-dev/build/bin/clang-cl" -DTEST_SUITE_COLLECT_COMPILE_TIME=OFF -DTEST_SUITE_LIT=/work/llvm-dev/build/bin/llvm-lit.py -DTEST_SUITE_SUBDIRS="SingleSource" ../llvm-test-suite

