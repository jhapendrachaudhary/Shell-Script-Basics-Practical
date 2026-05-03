#!/bin/bash

HOME_DIR="${1:-$HOME}"

if [[ ! -d "$HOME_DIR" ]]; then
    echo " Error: $HOME_DIR is not a valid directory."
    exit 1
fi

echo " Disk usage for: $HOME_DIR"
echo "----------------------------------------"

# Total size
total=$(du -sh "$HOME_DIR" 2>/dev/null | cut -f1)
echo "Total size: $total"

echo
echo "Top 10 largest subdirectories:"
du -h --max-depth=1 "$HOME_DIR" 2>/dev/null | sort -hr | head -10

echo
echo " Tip: Run 'ncdu ~' for an interactive disk usage browser (install with 'sudo apt install ncdu')"
