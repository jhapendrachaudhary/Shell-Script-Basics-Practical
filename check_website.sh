#!/bin/bash

# Script: check_website.sh
# Purpose: Ping a website/hostname to check if it's reachable
# Usage: ./check_website.sh <hostname_or_ip>

# Function to display usage
usage() {
    echo "Usage: $0 <hostname_or_ip>"
    echo "Example: $0 google.com"
    echo "         $0 8.8.8.8"
    exit 1
}

# Check if argument is provided
if [ $# -eq 0 ]; then
    echo "Error: No website specified."
    usage
fi

HOST="$1"
COUNT=4        # Number of ping attempts
TIMEOUT=10     # Timeout in seconds

echo "Checking if $HOST is reachable..."
echo "Sending $COUNT ICMP packets (timeout: ${TIMEOUT}s)..."

# Perform the ping test
if ping -c "$COUNT" -W "$TIMEOUT" "$HOST" > /dev/null 2>&1; then
    echo "SUCCESS: $HOST is reachable!"
    echo "Average latency: $(ping -c "$COUNT" -W "$TIMEOUT" "$HOST" | tail -1 | awk -F'/' '{print $5}') ms"
else
    echo "FAILED: $HOST is NOT reachable."
    echo " Possible causes: network down, host offline, firewall blocking ICMP, or DNS issue."
fi
