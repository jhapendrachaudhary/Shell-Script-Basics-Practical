#!/bin/bash

# 1. Check if a directory argument was provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory_path>"
    echo "Example: $0 /home/user/Documents"
    exit 1
fi

# 2. Store the provided directory path
DIR="$1"

# 3. Check if the provided path is a valid directory
if [ ! -d "$DIR" ]; then
    echo "Error: '$DIR' is not a valid directory."
    exit 1
fi

# 4. Count files (excluding directories, symlinks, etc.)
#    -maxdepth 1: only count items in this directory, not subdirectories
#    -type f: only regular files
file_count=$(find "$DIR" -maxdepth 1 -type f | wc -l)

# 5. Count directories (including hidden ones like .git)
#    -type d: directories only
#    Note: this includes the parent directory itself if we don't exclude it,
#          but -maxdepth 1 + starting from "$DIR" means we get only its contents
dir_count=$(find "$DIR" -maxdepth 1 -type d | wc -l)

#    However, the above includes the root "$DIR" itself!
#    So subtract 1 to count only subdirectories inside it
dir_count=$((dir_count - 1))

# 6. Output the results
echo "Directory: $DIR"
echo "Number of files: $file_count"
echo "Number of subdirectories: $dir_count"
