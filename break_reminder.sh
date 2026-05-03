#!/bin/bash

# break-reminder.sh
# Gently reminds you to take a break every 60 minutes

set -euo pipefail

# Default break interval: 60 minutes (3600 seconds)
INTERVAL_MINUTES=${1:-60}
INTERVAL_SECONDS=$((INTERVAL_MINUTES * 60))

# Validate input
if ! [[ "$INTERVAL_MINUTES" =~ ^[0-9]+$ ]] || [ "$INTERVAL_MINUTES" -lt 1 ]; then
    echo " Error: Please provide a positive integer (minutes)." >&2
    echo "Usage: $0 [minutes]"
    echo "Example: $0 60   → reminder every 60 minutes"
    exit 1
fi

# Detect desktop environment for notifications
NOTIFY_CMD=""
if command -v notify-send &> /dev/null; then
    NOTIFY_CMD="notify-send"
elif command -v osascript &> /dev/null; then
    # macOS support (optional)
    NOTIFY_CMD="osascript -e 'display notification \"Time for a break!\" with title \"Break Reminder\"'"
fi

echo " Break Reminder Active!"
echo "You'll get a reminder every $INTERVAL_MINUTES minute(s)."
echo "Press Ctrl+C to stop."

# Main loop
while true; do
    sleep "$INTERVAL_SECONDS"

    MESSAGE=" Time for a break! Stretch, hydrate, or rest your eyes."

    # Try desktop notification first
    if [ -n "$NOTIFY_CMD" ]; then
        if [ "$NOTIFY_CMD" = "notify-send" ]; then
            notify-send --urgency=normal --expire-time=5000 "Break Reminder" "$MESSAGE"
        else
            eval "$NOTIFY_CMD"
        fi
    fi

    # Always print to terminal (in case you're watching)
    echo
    echo "[$(date '+%Y-%m-%d %H:%M:%S')]  $MESSAGE"
    echo
done
