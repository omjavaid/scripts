#!/bin/bash

export CC=$HOME/work/llvm-dev/build/bin/clang-cl
export CXX=$HOME/work/llvm-dev/build/bin/clang-cl
export FF=$HOME/work/llvm-dev/build/bin/flang-new

export NO_STOP_MESSAGE=1

cmake -G Ninja -DTEST_SUITE_FORTRAN=ON -DCMAKE_Fortran_COMPILER=$FF -DTEST_SUITE_COLLECT_COMPILE_TIME=ON -DTEST_SUITE_LIT=/work/llvm-dev/build/bin/llvm-lit.py -DTEST_SUITE_SUBDIRS="Fortran" ../llvm-test-suite

# Uncomment the following line if needed
# cmake -G Ninja -DCMAKE_C_COMPILER="/work/llvm-dev/build/bin/clang-cl" -DTEST_SUITE_COLLECT_COMPILE_TIME=OFF -DTEST_SUITE_LIT=/work/llvm-dev/build/bin/llvm-lit.py -DTEST_SUITE_SUBDIRS="SingleSource" ../llvm-test-suite

