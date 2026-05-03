#!/bin/bash

# lowercase-filenames.sh
# Rename all files in a directory (recursively) to lowercase
# Usage: ./lowercase-filenames.sh [directory]

set -euo pipefail

usage() {
    echo "Usage: $0 [DIRECTORY]"
    echo "  Converts all filenames in DIRECTORY to lowercase (recursive)."
    echo "  If no directory is given, uses current directory."
    echo
    echo "Examples:"
    echo "  $0"
    echo "  $0 ~/Pictures"
    exit 1
}

if [[ "${1:-}" == "-h" ]] || [[ "${1:-}" == "--help" ]]; then
    usage
fi

# Set target directory (default: current)
TARGET_DIR="${1:-.}"

# Validate directory
if [[ ! -d "$TARGET_DIR" ]]; then
    echo " Error: '$TARGET_DIR' is not a valid directory." >&2
    exit 1
fi

# Convert to absolute path
TARGET_DIR="$(realpath "$TARGET_DIR")"

echo " Renaming files in: $TARGET_DIR (recursive)"
echo "--------------------------------------------"

# Use find to process files safely (handles spaces, newlines, etc.)
while IFS= read -r -d '' file; do
    dir=$(dirname "$file")
    old_name=$(basename "$file")
    new_name=$(echo "$old_name" | tr '[:upper:]' '[:lower:]')

    # Only rename if name actually changes
    if [[ "$old_name" != "$new_name" ]]; then
        new_path="$dir/$new_name"

        # Avoid overwriting existing files
        if [[ -e "$new_path" ]]; then
            echo "  Skipped: '$old_name' → '$new_name' (target exists)"
        else
            mv "$file" "$new_path"
            echo " Renamed: '$old_name' → '$new_name'"
        fi
    fi
done < <(find "$TARGET_DIR" -type f -print0)

echo " Done!"
