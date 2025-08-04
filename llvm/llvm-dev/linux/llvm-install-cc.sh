#!/bin/bash

# This script sets up wrappers scripts for cc and c++ in /usr/local/bin/ allowing
# user to call custom clang/clang++ binaries using `cc` and `c++` aliases.
#
# Usage:
# ------
#   sudo ./setup_llvm.sh /path/to/clang+llvm-17.0.6-aarch64-linux-gnu
#
# Arguments:
# ----------
#   /path/to/clang+llvm-17.0.6-aarch64-linux-gnu
#   The path to the unzipped LLVM folder containing the `clang` and `clang++`
#   binaries in bin directory.
#

if [ -z "$1" ]; then
  echo "Usage: $0 <path_to_llvm_folder>"
  exit 1
fi

LLVM_PATH=$1

if [ ! -d "$LLVM_PATH" ]; then
  echo "Error: Directory $LLVM_PATH does not exist."
  exit 1
fi

CLANG_BIN="$LLVM_PATH/bin/clang"
CLANGPP_BIN="$LLVM_PATH/bin/clang++"

if [ ! -f "$CLANG_BIN" ] || [ ! -f "$CLANGPP_BIN" ]; then
  echo "Error: clang or clang++ not found in $LLVM_PATH/bin."
  exit 1
fi

sudo touch /usr/local/bin/cc
sudo chmod +x /usr/local/bin/cc
echo "#!/bin/sh
$CLANG_BIN \"\$@\"" | sudo tee /usr/local/bin/cc > /dev/null

sudo touch /usr/local/bin/c++
sudo chmod +x /usr/local/bin/c++
echo "#!/bin/sh
$CLANGPP_BIN \"\$@\"" | sudo tee /usr/local/bin/c++ > /dev/null

echo "Setup completed successfully."

