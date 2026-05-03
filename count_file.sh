#!/bin/bash

# count-file.sh
# Count lines, words, and characters in a given file

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <filename>"
    echo "Example: $0 report.txt"
    exit 1
fi

FILE="$1"

# Check if file exists
if [ ! -f "$FILE" ]; then
    echo " Error: File '$FILE' not found."
    exit 1
fi

# Get counts using `wc`
read lines words chars < <(wc "$FILE")

# Display results
echo " File: $FILE"
echo "------------------"
echo "Lines    : $lines"
echo "Words    : $words"
echo "Chars    : $chars"
