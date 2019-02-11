################################################################################
git clone --depth 1 git://sourceware.org/git/binutils-gdb.git
cd binutils-gdb
export PATH=/home/omair/dev/toolchains/gcc-linaro-5.1-2015.08-x86_64_arm-linux-gnueabi/bin:$PATH
./configure --target=arm-linux-gnueabi --with-expat --disable-nls --disable-sim --disable-install-libbfd
make -j8 all-gdb
mv ./gdb/gdb ../arm-linux-gnueabi-gdb
make distclean
./configure --target=arm-linux-gnueabihf --with-expat --disable-nls --disable-sim --disable-install-libbfd
make -j8 all-gdb
mv ./gdb/gdb ../arm-linux-gnueabihf-gdb
make distclean
./configure --target=aarch64-linux-gnu --with-expat --disable-nls --disable-sim --disable-install-libbfd
make -j8 all-gdb
mv ./gdb/gdb ../aarch64-linux-gnu-gdb
make distclean
./configure --target=arm-linux-androideabi --with-expat --disable-nls --disable-sim --disable-install-libbfd
make -j8 all-gdb
mv ./gdb/gdb ../arm-linux-androideabi-gdb
make distclean
./configure --target=aarch64-linux-android --with-expat --disable-nls --disable-sim --disable-install-libbfd
make -j8 all-gdb
mv ./gdb/gdb ../aarch64-linux-android-gdb
make distclean
################################################################################
cd gdb/gdbserver
./configure --host=arm-linux-gnueabi
make -j8
mv ./gdbserver ../../../arm-linux-gnueabi-gdbserver
make distclean
./configure --host=arm-linux-gnueabihf
make -j8
mv ./gdbserver ../../../arm-linux-gnueabihf-gdbserver
make distclean
./configure --host=aarch64-linux-gnu
make -j8
mv ./gdbserver ../../../aarch64-linux-gnu-gdbserver
make distclean
rm -rf binutils-gdb
#./configure --host=aarch64-linux-android
#./configure --host=aarch64-linux-android CFLAGS='-w -fPIC' LDFLAGS='-pie'
################################################################################
##Apply Patch##
#export PATH=/home/omair/dev/toolchains/arm32-android-toolchain/bin:$PATH
#./configure --host=arm-linux-androideabi 
#make -j8
#mv ./gdbserver ../../../arm-linux-androideabi-gdbserver
#make distclean
################################################################################
#export PATH=/home/omair/dev/toolchains/arm64-android-toolchain/bin:$PATH
#./configure --host=arm-linux-androideabi 
#make -j8
#mv ./gdbserver ../../../arm-linux-androideabi-gdbserver
#make distclean
################################################################################
