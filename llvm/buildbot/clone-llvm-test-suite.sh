#!/bin/bash

# Define the repository URLs
LLVM_TEST_SUITE_URL="https://github.com/llvm/llvm-test-suite.git"

# Clone llvm-test-suite if the directory doesn't exist
if [ ! -d "llvm-test-suite" ]; then
    echo "Cloning llvm-test-suite..."
    git clone $LLVM_TEST_SUITE_URL
else
    echo "llvm-test-suite directory already exists. Skipping clone."
fi

echo "Script complete."
