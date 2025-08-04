#!/bin/bash

# Define the repository URLs
LLVM_PROJECT_URL="https://github.com/llvm/llvm-project.git"

# Clone llvm-project if the directory doesn't exist
if [ ! -d "llvm-project" ]; then
    echo "Cloning llvm-project..."
    git clone $LLVM_PROJECT_URL
else
    echo "llvm-project directory already exists. Skipping clone."
fi

echo "Script complete."
