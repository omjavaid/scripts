rm -rf ./build/host
mkdir -p ./build/host
cd ./build/host
#CFLAGS="-fuse-ld=gold"
cmake -GNinja -DCMAKE_BUILD_TYPE=Debug \
-DCMAKE_C_COMPILER=gcc  -DCMAKE_CXX_COMPILER=g++ \
"-DLLVM_TARGETS_TO_BUILD=X86;ARM;AArch64" \
-DCMAKE_C_FLAGS="$CFLAGS" -DCMAKE_CXX_FLAGS="$CFLAGS" \
../../llvm
ninja
