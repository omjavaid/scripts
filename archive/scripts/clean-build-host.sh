pushd .

BUILD_TYPE=

cd /home/omair/work/lldb/lldb-dev/build

if [ "$1" == "debug" ] ; then
  mkdir debug
  cd debug
  BUILD_TYPE=Debug
elif [ "$1" == "release" ] ; then
  mkdir release
  cd release
  BUILD_TYPE=Release
else
  exit
fi

rm -rf ./host

mkdir host

cd host

LLVM_SRC_DIR=/home/omair/work/lldb/lldb-dev/llvm-project

#In order to build the documentation need to add -DLLVM_ENABLE_SPHINX=ON.
#Once you do this you can build the docs using docs-lld-html build (ninja or make) target.

cmake -G Ninja \
-DCMAKE_BUILD_TYPE=$BUILD_TYPE \
-DCMAKE_INSTALL_PREFIX=../install \
-DLLVM_ENABLE_PROJECTS="lld;lldb;clang" \
-DLLVM_ENABLE_ASSERTIONS=True \
-DLLVM_LIT_ARGS="-svj 16" \
-DLLVM_USE_LINKER=gold \
-DCMAKE_C_COMPILER=clang \
-DCMAKE_CXX_COMPILER=clang++ \
-DCMAKE_C_COMPILER_LAUNCHER=ccache \
-DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
-DLLVM_PARALLEL_LINK_JOBS=4 \
-DLLVM_ENABLE_SPHINX=ON \
$LLVM_SRC_DIR/llvm

ninja

popd
