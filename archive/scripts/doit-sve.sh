#!/bin/bash
LLDB_REMOTE_SSH_HOST_NAME=qemu-bionic-arm64

LLVM_BUILD_DIR=/home/omair/work/lldb/lldb-dev/llvm-project/build

LLVM_DO_CMD=${1,,}
LLVM_BUILD_TYPE=${2,,}
LLVM_NINJA_ARCH=${3,,}

LLVM_NINJA_TARGET=
if [ "$LLVM_DO_CMD" = "test" ]; then
  LLVM_NINJA_TARGET=check-lldb
fi

if [ "$LLVM_NINJA_ARCH" = "arm" ] || [ "$LLVM_NINJA_ARCH" = "aarch64" ]; then
  LLVM_NINJA_TARGET=lldb-server
fi

case $LLVM_DO_CMD-$LLVM_BUILD_TYPE-$LLVM_NINJA_ARCH in
    build-debug-host | build-release-host | \
    build-debug-arm | build-release-arm | \
    build-debug-aarch64 | build-release-aarch64 | \
    test-debug-host | test-release-host)
        pushd .
        cd $LLVM_BUILD_DIR/${LLVM_BUILD_TYPE^}/${LLVM_NINJA_ARCH}-linux
        ninja $LLVM_NINJA_TARGET
        popd
    ;;
    copy-qemu-debug)
        echo "Deleting /home/omair/lldb-sve/lldb-server on $LLDB_REMOTE_SSH_HOST_NAME"
        ssh $LLDB_REMOTE_SSH_HOST_NAME 'rm /home/omair/lldb-sve/lldb-server'
        ssh $LLDB_REMOTE_SSH_HOST_NAME 'ls -al /home/omair/lldb-sve/'
        echo "Copying /home/omair/work/lldb/lldb-dev/build/debug/aarch64-linux-gnu/bin/lldb-server to $LLDB_REMOTE_SSH_HOST_NAME:/home/omair/lldb-sve/"
        scp /home/omair/work/lldb/lldb-dev/build/debug/aarch64-linux-gnu/bin/lldb-server $LLDB_REMOTE_SSH_HOST_NAME:/home/omair/lldb-sve/
        ssh $LLDB_REMOTE_SSH_HOST_NAME 'ls -al /home/omair/lldb-sve/'
    ;;
    copy-qemu-release)
        ssh $LLDB_REMOTE_SSH_HOST_NAME "ps -A | grep lldb-server | awk '{print \$1}' | xargs kill || true"
        echo "Deleting /home/omair/lldb-sve/lldb-server on $LLDB_REMOTE_SSH_HOST_NAME"
        ssh $LLDB_REMOTE_SSH_HOST_NAME 'rm /home/omair/lldb-sve/lldb-server'
        ssh $LLDB_REMOTE_SSH_HOST_NAME 'ls -al /home/omair/lldb-sve/'
        echo "Copying /home/omair/work/lldb/lldb-dev/build/release/aarch64-linux-gnu/bin/lldb-server to $LLDB_REMOTE_SSH_HOST_NAME:/home/omair/lldb-sve/"
        scp /home/omair/work/lldb/lldb-dev/build/release/aarch64-linux-gnu/bin/lldb-server $LLDB_REMOTE_SSH_HOST_NAME:/home/omair/lldb-sve/
        ssh $LLDB_REMOTE_SSH_HOST_NAME 'ls -al /home/omair/lldb-sve/'
    ;;

    *)
        # unknown option
    ;;
esac
