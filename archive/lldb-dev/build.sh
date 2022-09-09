#!/usr/bin/env bash

set -e
set -x

if [[ $# -eq 0 ]] ; then
  echo 'Missing commandline arguments.'
  echo 'Usage: [host|arm|armhf|aarch|arm64|arm32] [debug] [clean]'
  exit 0
fi

################################################################################
ANDROID_TOOLCHAIN_HOME=/home/omair/work/toolchains/
BUILD_HOME=$(pwd)
TRIPLE=
case "$1" in
  host)
  BUILD_DIR=$BUILD_HOME/build/host
  ;;
  arm)
  ARCH=ARM
  TRIPLE=arm-linux-gnueabi
  BUILD_DIR=$BUILD_HOME/build/$TRIPLE
  ;;
  armhf)
  ARCH=ARM
  TRIPLE=arm-linux-gnueabihf
  BUILD_DIR=$BUILD_HOME/build/$TRIPLE
  ;;
  aarch64)
  ARCH=AArch64
  TRIPLE=aarch64-linux-gnu
  BUILD_DIR=$BUILD_HOME/build/$TRIPLE
  ;;
  arm64)
  ABI=aarch64
  ARCH=AArch64
  TRIPLE=aarch64-unknown-linux-android
  ANDROID_TOOLCHAIN=/home/omair/work/toolchains/arm64-android-toolchain
  BUILD_DIR=$BUILD_HOME/build/$TRIPLE
  ;;
  arm32)
  ABI=armeabi
  ARCH=ARM
  TRIPLE=arm-unknown-linux-android
  ANDROID_TOOLCHAIN=/home/omair/work/toolchains/arm32-android-toolchain
  BUILD_DIR=$BUILD_HOME/build/$TRIPLE
  ;;
  *)
  echo 'Invalid build host name.'
  echo 'Usage: [host|arm|armhf|aarch|arm64|arm32] [debug] [clean]'
  exit
  ;;
esac


################################################################################
################################################################################


function cleanUp {
    rm -rf $1
    mkdir $1
}

function maybeCleanUp {
  if [ -f "$1-incomplete" ]; then
    cleanUp $1
  fi

  if [ ! -d "$1" ]; then
    mkdir $1
  fi
}

function markBuildIncomplete {
    touch $BUILD_DIR-incomplete
}

function markBuildComplete {
    rm $BUILD_DIR-incomplete
}

function linuxMake {
  cmake -GNinja ../../llvm \
-DCMAKE_BUILD_TYPE=$BUILD_TYPE \
-DCMAKE_C_COMPILER=$TRIPLE-gcc \
-DCMAKE_CXX_COMPILER=$TRIPLE-g++ \
-DLLVM_HOST_TRIPLE=$TRIPLE \
-DLLVM_TARGETS_TO_BUILD=$ARCH \
-DLLVM_TARGET_ARCH=$ARCH \
-DCMAKE_CROSSCOMPILING=1 \
-DLLDB_DISABLE_PYTHON=1 \
-DLLDB_DISABLE_LIBEDIT=1 \
-DLLDB_DISABLE_CURSES=1 \
-DLLVM_TABLEGEN=$BUILD_DIR/../host/bin/llvm-tblgen \
-DCLANG_TABLEGEN=$BUILD_DIR/../host/bin/clang-tblgen
}

function androidMake {
  cmake -GNinja ../../llvm \
-DCMAKE_BUILD_TYPE=$BUILD_TYPE \
-DANDROID_TOOLCHAIN_DIR=$ANDROID_TOOLCHAIN \
-DCMAKE_TOOLCHAIN_FILE=../../llvm/tools/lldb/cmake/platforms/Android.cmake \
-DANDROID_ABI=$ABI \
-DLLVM_TARGET_ARCH=$ARCH \
-DLLVM_HOST_TRIPLE=$TRIPLE \
-DLLVM_TARGETS_TO_BUILD=$ARCH \
-DCMAKE_CXX_COMPILER_VERSION=4.9 \
-DLLVM_TABLEGEN=$BUILD_DIR/../host/bin/llvm-tblgen \
-DCLANG_TABLEGEN=$BUILD_DIR/../host/bin/clang-tblgen
}

function hostMake {
  cmake -GNinja ../../llvm \
-DCMAKE_BUILD_TYPE=$BUILD_TYPE \
-DCMAKE_C_COMPILER=gcc \
-DCMAKE_CXX_COMPILER=g++ \
"-DLLVM_TARGETS_TO_BUILD=X86;ARM;AArch64"
}

function build {
  JOBS=$(cat /proc/cpuinfo | grep -c processor)
  nice -n 10 ninja -j$JOBS $1 
}

function cmakenbuild {
  dir=$buildDir/$1
  mkdir -p $dir && cd $dir
  crossMake $1 $2
  build
}


################################################################################
################################################################################


BUILD_TYPE=
case "$2" in
  debug)
  BUILD_TYPE=Debug
  ;;
  clean)
  BUILD_TYPE=Release
  cleanUp $BUILD_DIR
  ;;
  *)
  BUILD_TYPE=Release
  ;;
esac

case "$3" in
  clean)
  cleanUp $BUILD_DIR
  ;;
  *)
  maybeCleanUp $BUILD_DIR
  ;;
esac


################################################################################
################################################################################


cd $BUILD_DIR

case "$1" in
    host)
    markBuildIncomplete
    hostMake
    build "lldb lldb-server clang-tblgen llvm-tblgen"
    markBuildComplete
    ;;
    arm)
    markBuildIncomplete
    linuxMake
    build "lldb-server"
    markBuildComplete
    ;;
    armhf)
    markBuildIncomplete
    linuxMake
    build "lldb-server"
    markBuildComplete
    ;;
    aarch64)
    markBuildIncomplete
    linuxMake
    build "lldb-server"
    markBuildComplete
    ;;
    arm64)
    markBuildIncomplete
    androidMake
    build "lldb-server"
    markBuildComplete
    ;;
    arm32)
    markBuildIncomplete
    androidMake
    build "lldb-server"
    markBuildComplete
    ;;
    *)
    echo 'Invalid build host name.'
    echo 'Usage: [host|arm|armhf|aarch|arm64|arm32] [clean|re]'
    exit
    ;;
esac

