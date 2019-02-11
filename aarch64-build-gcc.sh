TRIPLE=aarch64-linux-gnu
mkdir -p ./build/$TRIPLE/ && cd ./build/$TRIPLE/ && rm -rf *
cmake -G Ninja ../../llvm \
-DCMAKE_CROSSCOMPILING=1 \
-DLLVM_TARGETS_TO_BUILD=AArch64 \
-DCMAKE_C_COMPILER=$TRIPLE-gcc \
-DCMAKE_CXX_COMPILER=$TRIPLE-g++ \
-DLLVM_HOST_TRIPLE=$TRIPLE \
-DLLVM_TABLEGEN=$PWD/../host/bin/llvm-tblgen \
-DCLANG_TABLEGEN=$PWD/../host/bin/clang-tblgen \
-DLLDB_DISABLE_PYTHON=1 \
-DLLDB_DISABLE_LIBEDIT=1 \
-DLLDB_DISABLE_CURSES=1 \
-DCMAKE_BUILD_TYPE=$1
ninja lldb-server
cd ../..
