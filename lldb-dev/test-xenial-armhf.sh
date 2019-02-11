if [[ $# -eq 0 ]] ; then
    echo 'some message'
    exit 0
fi

case "$1" in
    chrome)
    hostName=chromeBook
    testConfig=xenial-armhf
    remoteDir=/home/omair/lldb/xenial-armhf
    localDir=/home/omair/work/lldb-dev
    triple=arm-linux-gnueabihf
    arch=arm
    chrootCMD="schroot -c chroot:xenial-armhf --"
    ;;
    hikey)

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

if [ ! -d "$localDir/test" ]; then
  mkdir $localDir/test
fi

# Kill any already running instance of lldb-server
ssh $hostName "ps -A | grep lldb-server | awk '{print \$1}' | xargs kill || true"

# Delete existing lldb-server instance from remote location if any
ssh $hostName "rm -f $remoteDir/lldb-server"

# Copy lldb-server binary to remoteDir
scp $localDir/build/$triple/bin/lldb-server $hostName:$remoteDir/

# Screen Spawn remote lldb-server in relevent chroot
screen -d -m ssh $hostName "$chrootCMD $remoteDir/lldb-server platform --listen *:5432 --server"

sleep 5

cd llvm/tools/lldb/test

DOTEST_OPTS="--executable $localDir/build/host/bin/lldb -A $arch -C $triple-gcc \
-s $localDir/test/$testConfig-$hostName --skip-category lldb-mi -u CXXFLAGS \
-u CFLAGS --platform-name remote-linux --platform-url connect://$hostName:5432 \
--platform-working-dir $remoteDir/tmp --env OS=Linux $2"

./dotest.py `echo $DOTEST_OPTS`

cd ../../../..
