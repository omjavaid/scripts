mkdir -p build/host
cd build/host
CFLAGS="-fuse-ld=gold -Wunused-arguments -fcolor-diagnostics"
CC="clang-3.5 $CFLAGS"
CXX="clang++-3.5 $CFLAGS"
cmake -GNinja -DCMAKE_BUILD_TYPE=Debug "-DLLVM_TARGETS_TO_BUILD=X86;ARM;AArch64" ../../llvm
ninja

