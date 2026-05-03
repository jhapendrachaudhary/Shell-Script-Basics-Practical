#!/bin/bash

# check_command.sh
# Usage: ./check_command.sh <command_name>

CMD="$1"

if [ -z "$CMD" ]; then
    echo "Usage: $0 <command_name>"
    exit 1
fi

if command -v "$CMD" &> /dev/null; then
    echo " '$CMD' is installed."
else
    echo " '$CMD' is NOT installed."
fi
