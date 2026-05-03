#!/bin/bash

# Script: remove_empty_files.sh
# Purpose: Find and delete empty files (0 bytes) in a given directory
# Usage: ./remove_empty_files.sh [directory]   (defaults to current directory)

# Set default directory
TARGET_DIR="${1:-.}"

# Validate directory
if [[ ! -d "$TARGET_DIR" ]]; then
    echo " Error: '$TARGET_DIR' is not a valid directory."
    echo "Usage: $0 [directory_path]"
    echo "Example: $0 /home/user/documents"
    exit 1
fi

# Convert to absolute path for clarity
TARGET_DIR="$(realpath "$TARGET_DIR")"

echo " Scanning for empty files in: $TARGET_DIR"

# Find all empty files (0 bytes, regular files only)
mapfile -d '' empty_files < <(find "$TARGET_DIR" -type f -empty -print0 2>/dev/null)

# Check if any empty files found
if [[ ${#empty_files[@]} -eq 0 ]]; then
    echo " No empty files found."
    exit 0
fi

echo " Found ${#empty_files[@]} empty file(s):"
printf '  - %s\n' "${empty_files[@]}"

# Confirm before deletion (safety first!)
echo
read -p "❓ Delete these empty files? (y/N): " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo " Deletion cancelled."
    exit 0
fi

# Delete empty files
deleted=0
for file in "${empty_files[@]}"; do
    if rm -f "$file" 2>/dev/null; then
        ((deleted++))
        echo " Deleted: $file"
    else
        echo " Failed to delete: $file"
    fi
done

echo
echo " Done! $deleted empty file(s) removed."
