#!/bin/bash

# Function to handle the checkout-llvm-project option
checkout_llvm_project() {
    local revision="$1"
    
    # Check if the .git directory exists
    if [ ! -d ".git" ]; then
        # Initialize a new git repository
        git init
    fi
    
    git --version
    git cat-file -e "$revision" &> /dev/null || true  # Will not fail if revision does not exist
    git fetch -t https://github.com/llvm/llvm-project.git main --progress
    git reset --hard "$revision" --
    git checkout -B main
    git rev-parse HEAD
}

# Check if a directory is provided or use PWD
WORK_DIR="${2:-$PWD}"

# Check if the llvm directory exists in the given directory
if [ ! -d "$WORK_DIR/llvm" ]; then
    echo "Error: 'llvm' directory not found in $WORK_DIR."
    exit 1
fi

# Change to the llvm directory
cd "$WORK_DIR/llvm"

# Check the arguments passed for the git operations
case "$1" in
    checkout-llvm-project|co-llvm)
        if [ -z "$3" ]; then
            echo "Please provide a revision for the checkout-llvm-project option."
            exit 1
        else
            checkout_llvm_project "$3"
        fi
        ;;
    *)
        echo "Usage: $0 {checkout-llvm-project|co-llvm} [work-dir] <revision>"
        ;;
esac
