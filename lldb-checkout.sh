#!/bin/bash

if [ $# -eq 0 ]
  then
    svn co https://llvm.org/svn/llvm-project/llvm/trunk llvm
    cd llvm/tools
    svn co https://llvm.org/svn/llvm-project/cfe/trunk clang
    svn co https://llvm.org/svn/llvm-project/lldb/trunk lldb
  else
    svn co -r $1 https://llvm.org/svn/llvm-project/llvm/trunk llvm
    cd llvm/tools
    svn co -r $1 https://llvm.org/svn/llvm-project/cfe/trunk clang
    svn co -r $1 https://llvm.org/svn/llvm-project/lldb/trunk lldb
fi

