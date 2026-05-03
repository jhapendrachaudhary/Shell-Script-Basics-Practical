#!/bin/bash

# genpass.sh — Generate a random password
# Usage: ./genpass.sh [length] [use_special_chars?]
# Example: ./genpass.sh 16 y   → 16-char password with symbols

# Default settings
LENGTH=${1:-12}          # Default length: 12
USE_SPECIAL=${2:-n}      # Default: no special characters

# Validate length
if ! [[ "$LENGTH" =~ ^[0-9]+$ ]] || [ "$LENGTH" -lt 1 ]; then
    echo " Error: Password length must be a positive integer." >&2
    exit 1
fi

# Define character set
CHARS="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
if [[ "$USE_SPECIAL" =~ ^[yY1] ]]; then
    CHARS+="!@#$%^&*()_+-=[]{}|;:,.<>?"
fi

# Generate password using /dev/urandom (cryptographically secure)
PASSWORD=$(tr -dc "$CHARS" < /dev/urandom | head -c "$LENGTH")

# Output
echo "$PASSWORD"
