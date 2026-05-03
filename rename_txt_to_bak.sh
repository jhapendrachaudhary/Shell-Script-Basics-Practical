#!/bin/bash

# Script: rename_txt_to_bak.sh
# Purpose: Rename all .txt files in current directory to .bak
# Safety: Checks if files exist, avoids overwrites

echo " Looking for .txt files in current directory..."

# Check if any .txt files exist
if ! compgen -G "*.txt" > /dev/null; then
    echo " No .txt files found."
    exit 1
fi

echo " Found .txt files. Renaming..."

# Rename each .txt file to .bak
for file in *.txt; do
    # Safety: Skip if glob didn't match (shouldn't happen due to check above)
    [[ -f "$file" ]] || continue
    
    # Create new name: replace .txt with .bak
    new_name="${file%.txt}.bak"
    
    # Warn if target already exists
    if [[ -e "$new_name" ]]; then
        echo " Warning: $new_name already exists. Skipping $file"
        continue
    fi
    
    # Perform rename
    mv "$file" "$new_name"
    echo " Renamed: $file → $new_name"
done

echo " Done!"
