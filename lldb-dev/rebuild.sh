if [[ $# -eq 0 ]] ; then
    echo 'some message'
    exit 0
fi

case "$1" in
    host)
    BUILD_DIR=$(pwd)/build/host
    ;;
    arm)
    BUILD_DIR=$(pwd)/build/arm-linux-gnueabi
    ;;
    armhf)
    BUILD_DIR=$(pwd)/build/arm-linux-gnueabihf
    ;;
    aarch64)
    BUILD_DIR=$(pwd)/build/aarch64-linux-gnu
    ;;
    arm64)
    BUILD_DIR=$(pwd)/build/android-arm64
    ;;
    arm32)
    BUILD_DIR=$(pwd)/build/android-arm32
    ;;
    *)
    echo 'Unknown Target / Host Name'
    exit
    ;;
esac

if [ ! -d "$BUILD_DIR" ]; then
    echo 'Unknown Target / Host Name'
    exit
fi

cd $BUILD_DIR

case "$1" in
    host)
    ninja lldb lldb-server llvm-tblgen clang-tblgen
    ;;
    *)
    ninja lldb-server 
    ;;
esac
