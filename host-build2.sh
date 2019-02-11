mkdir -p build/host
cd build/host
CFLAGS="-fuse-ld=gold -fno-limit-debug-info"
cmake -GNinja -DCMAKE_BUILD_TYPE=Debug \
-DCMAKE_C_COMPILER=clang-3.5  -DCMAKE_CXX_COMPILER=clang++-3.5 \
"-DLLVM_TARGETS_TO_BUILD=X86;ARM;AArch64" \
-DCMAKE_C_FLAGS="$CFLAGS" -DCMAKE_CXX_FLAGS="$CFLAGS" \
../../llvm
ninja
