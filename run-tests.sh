#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'some message'
    exit 0
fi
cd llvm/tools/lldb/test
case "$1" in
    armhf)
    rm -rf /home/omair/work/lldb-dev/test/armhf-raspberryPi2
    DOTEST_OPTS="--executable /home/omair/work/lldb-dev/build/host/bin/lldb -A arm \
-C arm-linux-gnueabihf-gcc -v -s /home/omair/work/lldb-dev/test/armhf-raspberryPi2 \
--skip-category lldb-mi -u CXXFLAGS -u CFLAGS --platform-name remote-linux \
--platform-url connect://raspberryPi2:5432 --platform-working-dir \
/home/omair/lldb/armhf/tmp --env OS=Linux $2"
   ./dotest.py `echo $DOTEST_OPTS`
    ;;
    aarch64)
    rm -rf /home/omair/work/lldb-dev/test/aarch64-hiKey/
    DOTEST_OPTS="--executable /home/omair/work/lldb-dev/build/host/bin/lldb -A aarch64 \
-C aarch64-linux-gnu-gcc -s /home/omair/work/lldb-dev/test/aarch64-hiKey \
--skip-category lldb-mi -u CXXFLAGS -u CFLAGS --platform-name remote-linux \
--platform-url connect://hikey96board:5432 --platform-working-dir \
/home/omair/lldb/aarch64/tmp --env OS=Linux $2"
   ./dotest.py `echo $DOTEST_OPTS`
    ;;
    arm32)
    echo 'arm32'
    ;;
    arm64)
    echo 'arm64'
    ;;
    *)
    echo 'Unknown test setup type'

    ;;
esac
cd ../../../..
exit 0
