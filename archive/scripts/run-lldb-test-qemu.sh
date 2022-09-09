#!/bin/bash

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    echo "usage: run-lldb-test-qemu.sh <LLDB API test file name>.py <extra args>"
    echo "    -v  Do verbose mode of unittest framework (print out each test case invocation)"
    echo "    -t  Turn on tracing of lldb command and other detailed test executions"
    exit 1
fi

LLDB_BUILD_DIR=/home/omair/work/lldb/lldb-dev/llvm-project/build/Release/host-linux
#LLDB_TEST_COMPILER=/home/omair/work/tools/gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-gcc
#LLDB_TEST_COMPILER=/home/omair/work/tools/gcc-linaro-11.0.1-2021.03-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc
# Linaro integration build downloaded from linaro.org for MTE testing
LLDB_TEST_COMPILER=/home/omair/work/tools/gcc-linaro-11.0.0-2021.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc
LLDB_TEST_ARCH=aarch64

LLDB_PLATFORM_NAME=remote-linux
LLDB_PLATFORM_URL=connect://192.168.53.76:54321
#-u CXXFLAGS -u CFLAGS --env ARCHIVER=/usr/bin/ar --env OBJCOPY=/usr/bin/objcopy \

$LLDB_BUILD_DIR/bin/lldb-dotest \
-A $LLDB_TEST_ARCH \
-C $LLDB_TEST_COMPILER \
--build-dir $LLDB_BUILD_DIR/lldb-test-build.noindex \
--executable $LLDB_BUILD_DIR/bin/lldb \
--dsymutil $LLDB_BUILD_DIR/bin/dsymutil \
--llvm-tools-dir $LLDB_BUILD_DIR/bin \
--lldb-libs-dir $LLDB_BUILD_DIR/lib \
--platform-name=$LLDB_PLATFORM_NAME \
--platform-url=$LLDB_PLATFORM_URL \
-p $1 $2 $3
