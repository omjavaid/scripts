#!/bin/bash

if [ $# -gt 0 ]; then
    echo "Your command line contains $# arguments"
else
    echo "Your command line contains no arguments"
fi

while [ "$1" != "" ]; do
  case $1 in
    -f | --fresh )
      shift
      rm -rf ./build/host
      mkdir -p ./build/host
      ;;
    -h | --help )
      usage
      exit
      ;;
    * ) 
      mkdir -p ./build/host
  esac
  shift
done

if [ ! -d "build/host" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  exit 1
fi

cd ./build/host

C_COMPILER=clang
CXX_COMPILER=clang++

TARGET_C_FLAGS=
TARGET_CXX_FLAGS=

cmake -G Ninja \
-DCMAKE_BUILD_TYPE=Debug \
-DLLDB_EXPORT_ALL_SYMBOLS=1 \
-DLLVM_ENABLE_ASSERTIONS=On \
-DCMAKE_C_COMPILER=$C_COMPILER \
-DCMAKE_CXX_COMPILER=$CXX_COMPILER \
-DLLVM_USE_LINKER=gold \
-DCMAKE_C_FLAGS="$TARGET_C_FLAGS" \
-DCMAKE_CXX_FLAGS="$TARGET_CXX_FLAGS" \
-DLLVM_LIT_ARGS="-sv --threads=4" \
../../llvm

ninja lldb lldb-server llvm-tblgen clang-tblgen

cd ../..
