#!/bin/bash
# Run this script in the workspace root directory

# Get the directory where the script is located (workspace root)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# Get current working directory
CURRENT_DIR=$(pwd)

# Check if executing from workspace root directory
if [ "$SCRIPT_DIR" != "$CURRENT_DIR" ]; then
    echo "Error: Please run this script from the workspace root directory!"
    echo "Current directory: $CURRENT_DIR"
    echo "Workspace root: $SCRIPT_DIR"
    exit 1
fi

for pkg in deps/*; do
    pkg_name=$(basename "$pkg")
    if [ ! -e "src/$pkg_name" ]; then
        ln -s "../deps/$pkg_name" "src/$pkg_name"
        echo "Linked: src/$pkg_name -> ../deps/$pkg_name"
    else
        echo "Skipped: src/$pkg_name already exists"
    fi
done