#!/usr/bin/env bash

set -e
set -x

if [[ $# -eq 0 ]] ; then
  echo 'Missing commandline arguments.'
  echo 'Usage: [target-name] [host-name] [arm|aarch64] [port]'
  exit 0
fi

target_name=$1
host_name=$2
arch_name=$3
port=$4

test_config=$1-$3

llvm_home=$(pwd)
lldb_home=$(pwd)/llvm/tools/lldb
test_dir=$llvm_home/test
compiler=

remote_dir=
connect_url=connect://$1:$port

################################################################################
ANDROID_TOOLCHAIN_HOME=/home/omair/work/toolchains/
TEST_HOME=$(pwd)

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

case "$2" in
    armhf)
    compiler=arm-linux-gnueabihf-gcc
    arch=arm
    platform_name=remote-linux
    env_os=Linux
    ;;
    aarch64)
    compiler=aarch64-linux-gnu-gcc
    arch=aarch64
    platform_name=remote-linux
    env_os=Linux
    ;;
    arm64)
    compiler=/home/omair/work/toolchains/arm64-android-toolchain/bin/aarch64-linux-android-gcc
    arch=aarch64
    connect_url=connect://localhost:$port
    platform_name=remote-android
    env_os=Android
    ;;
    *)
    echo 'Unknown Architecture'
    exit
    ;;
esac

case "$1" in
    pi2one)
    remote_dir=/home/omair/lldb-test/tmp
    ;;
    pi3one)
    remote_dir=/home/omair/lldb-test/tmp
    ;;
    pi3two)
    remote_dir=/home/omair/lldb-test/tmp
    ;;
    pine64)
    remote_dir=/home/omair/lldb-test/$arch/tmp
    ;;
    hikeyCC)
    remote_dir=/home/omair/sdcard/lldb-test/$arch/tmp
    ;;
    nexus5x|nexus5|nexus7)
    remote_dir=/data/local/tmp/lldb/arm64/tmp
    ;;
    #chrootCMD="schroot -c chroot:xenial-armhf --"
    *)
    echo 'Unknown Target / Host Name'
    exit
    ;;
esac

rm -rf $test_dir/$test_config/*
mkdir -p $test_dir/$test_config

LLDB_TEST_THREADS=8

cmd="--executable $llvm_home/build/host/bin/lldb \
-A $arch -C $compiler \
-v -s $test_dir/$test_config -u CXXFLAGS -u CFLAGS \
--channel \"gdb-remote packets\" --channel \"lldb all\" \
--platform-name $platform_name \
--platform-url $connect_url \
--platform-working-dir $remote_dir \
--env OS=$env_os \
--skip-category lldb-mi $3"

echo $cmd | xargs $lldb_home/test/dotest.py
