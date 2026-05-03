#!/bin/bash
# Usage: ./notify_when_done.sh <command...>
# Example: ./notify_when_done.sh sleep 5

if [ $# -eq 0 ]; then
    echo "Usage: $0 <command> [args...]"
    echo "Example: $0 make"
    exit 1
fi

# Run the command
"$@"

# Play a sound when done
case "$OSTYPE" in
  linux*)
    # Use ' speaker-test' or 'beep' if available, fallback to terminal bell
    if command -v paplay &> /dev/null && [ -f /usr/share/sounds/generic-notify.wav ]; then
      paplay /usr/share/sounds/generic-notify.wav
    elif command -v beep &> /dev/null; then
      beep
    else
      printf '\a'  # Terminal bell (works in most terminals)
    fi
    ;;
  darwin*)
    # macOS: use system beep
    osascript -e 'beep'
    ;;
  msys*|cygwin*|win*)
    # Windows (Git Bash / WSL): terminal bell
    printf '\a'
    ;;
  *)
    # Fallback: terminal bell
    printf '\a'
    ;;
esac
