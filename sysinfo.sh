#!/bin/bash

# sysinfo.sh - Display basic system information

# Get OS name
if [ -f /etc/os-release ]; then
    # Most modern Linux distros
    . /etc/os-release
    OS="$NAME $VERSION"
elif [ "$(uname)" = "Darwin" ]; then
    # macOS
    OS="macOS $(sw_vers -productVersion)"
elif [ "$(uname)" = "FreeBSD" ]; then
    OS="FreeBSD"
else
    OS="$(uname -s)"
fi

# Get kernel info
KERNEL="$(uname -s) $(uname -r)"

# Get uptime in human-readable format
if command -v uptime >/dev/null 2>&1; then
    # Try to parse uptime from 'uptime' command
    UPTIME_OUTPUT=$(uptime)
    # Extract the part after "up" and before users/loads
    if [[ $UPTIME_OUTPUT =~ up[[:space:]]+([^,]+) ]]; then
        UPTIME="${BASH_REMATCH[1]}"
    else
        UPTIME="$(uptime)"
    fi
else
    # Fallback: read from /proc/uptime (Linux only)
    if [ -f /proc/uptime ]; then
        SECONDS=$(awk '{print int($1)}' /proc/uptime)
        DAYS=$((SECONDS / 86400))
        HOURS=$(( (SECONDS % 86400) / 3600 ))
        MINUTES=$(( (SECONDS % 3600) / 60 ))

        UPTIME=""
        [[ $DAYS -gt 0 ]] && UPTIME+="$DAYS day$([[ $DAYS -gt 1 ]] && echo s), "
        [[ $HOURS -gt 0 ]] && UPTIME+="$HOURS hour$([[ $HOURS -gt 1 ]] && echo s), "
        [[ $MINUTES -gt 0 ]] && UPTIME+="$MINUTES minute$([[ $MINUTES -gt 1 ]] && echo s)"
        UPTIME="${UPTIME%, }"
        [[ -z "$UPTIME" ]] && UPTIME="less than a minute"
    else
        UPTIME="Unknown"
    fi
fi

# Display results
echo "System Information"
echo "=================="
echo "OS:       $OS"
echo "Kernel:   $KERNEL"
echo "Uptime:   $UPTIME"
