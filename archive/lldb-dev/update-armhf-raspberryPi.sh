ssh raspberryPi "rm -f /home/omair/lldb/lldb-server"
scp build/arm-linux-gnueabihf/bin/lldb-server raspberryPi:/home/omair/lldb/
