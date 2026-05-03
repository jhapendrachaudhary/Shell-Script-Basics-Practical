#!/bin/bash

# 1. Check if argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <file_or_directory_path>"
    echo "Example: $0 /home/user/myfile.txt"
    echo "         $0 /home/user/Documents"
    exit 1
fi

# 2. Store the path
PATH_INPUT="$1"

# 3. Check if it exists
if [ ! -e "$PATH_INPUT" ]; then
    echo "Error: '$PATH_INPUT' does not exist."
    exit 1
fi

# 4. Function to convert bytes to human-readable format
human_readable() {
    local size=$1
    if [ "$size" -eq 0 ]; then
        echo "0 B"
    elif [ "$size" -lt 1024 ]; then
        echo "${size} B"
    elif [ "$size" -lt $((1024 * 1024)) ]; then
        echo "$((size / 1024)) KB"
    elif [ "$size" -lt $((1024 * 1024 * 1024)) ]; then
        echo "$((size / 1024 / 1024)) MB"
    else
        echo "$((size / 1024 / 1024 / 1024)) GB"
    fi
}

# 5. Handle FILE
if [ -f "$PATH_INPUT" ]; then
    # Get file size in bytes
    size_bytes=$(stat -c %s "$PATH_INPUT" 2>/dev/null || stat -f %z "$PATH_INPUT" 2>/dev/null)
    if [ -z "$size_bytes" ]; then
        size_bytes=$(wc -c < "$PATH_INPUT")
    fi
    size_human=$(human_readable "$size_bytes")
    echo "File: $PATH_INPUT"
    echo "Size: $size_human ($size_bytes bytes)"

# 6. Handle DIRECTORY
elif [ -d "$PATH_INPUT" ]; then
    # Use 'du' to get total size of directory (in bytes)
    # -s = summarize, -b = bytes (some systems use --bytes; fallback to -k if needed)
    if du --help | grep -q "\--bytes"; then
        size_bytes=$(du -sb "$PATH_INPUT" 2>/dev/null | cut -f1)
    else
        # Fallback for macOS/BSD: use -k and multiply by 1024
        size_kb=$(du -sk "$PATH_INPUT" 2>/dev/null | cut -f1)
        size_bytes=$((size_kb * 1024))
    fi

    # Handle empty or unreadable directory
    if [ -z "$size_bytes" ] || [ "$size_bytes" -eq 0 ]; then
        size_bytes=0
    fi

    size_human=$(human_readable "$size_bytes")
    echo "Directory: $PATH_INPUT"
    echo "Total size: $size_human ($size_bytes bytes)"

# 7. Handle other types (symlink, device, etc.)
else
    echo " '$PATH_INPUT' exists but is not a regular file or directory (e.g., symlink, device)."
    ls -ld "$PATH_INPUT"
fi
