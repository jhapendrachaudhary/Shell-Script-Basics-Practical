#!/bin/bash
# Usage: ./add_prefix.sh PREFIX [FILES...]
# Example: ./add_prefix.sh backup_ *.txt

prefix="$1"
shift  # Remove the first argument (prefix), leave only filenames

for file in "$@"; do
    mv "$file" "${prefix}${file}"
done
