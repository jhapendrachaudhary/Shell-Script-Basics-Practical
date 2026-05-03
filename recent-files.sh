#!/bin/bash

# recent-files.sh
# List all files modified in the last 24 hours

set -euo pipefail  # Safe scripting

usage() {
    echo "Usage: $0 [DIRECTORY]"
    echo "  Lists files modified in the last 24 hours."
    echo "  If DIRECTORY is not provided, searches current directory."
    echo
    echo "Examples:"
    echo "  $0"
    echo "  $0 /home"
    echo "  $0 /var/log"
    exit 1
}

# Handle help flag
if [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]; then
    usage
fi

# Set search directory (default: current dir)
SEARCH_DIR="${1:-.}"

# Validate directory
if [[ ! -d "$SEARCH_DIR" ]]; then
    echo " Error: '$SEARCH_DIR' is not a valid directory." >&2
    exit 1
fi

# Convert to absolute path (optional but cleaner)
SEARCH_DIR="$(realpath "$SEARCH_DIR")"

echo " Searching for files modified in the last 24 hours in: $SEARCH_DIR"
echo "-------------------------------------------------------------------"

# Find and display files with details
if find "$SEARCH_DIR" -type f -newermt "24 hours ago" -exec ls -lh {} + 2>/dev/null | grep -q .; then
    find "$SEARCH_DIR" -type f -newermt "24 hours ago" -exec ls -lh {} +
else
    echo " No files modified in the last 24 hours."
fi
