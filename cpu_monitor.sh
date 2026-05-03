#!/bin/bash

THRESHOLD=80
INTERVAL=2  # Check more frequently to catch short spikes

echo "🔍 Monitoring CPU usage... (Press Ctrl+C to stop)"

while true; do
    # Get total CPU usage (busy %)
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
    CPU_USAGE=${CPU_USAGE%.*}  # Remove decimal

    echo "Current CPU usage: ${CPU_USAGE}%"

    if [ "$CPU_USAGE" -gt "$THRESHOLD" ]; then
        echo "⚠️  ALERT: CPU usage is above ${THRESHOLD}%! (${CPU_USAGE}%)"
        echo "🕒 Time: $(date)"
        echo "📌 Top processes using CPU right now:"
        # Show top 5 processes by CPU%
        ps aux --sort=-%cpu | head -n 6  # 1 header + 5 processes
        echo "──────────────────────────────────────────"
        echo ""
    fi

    sleep "$INTERVAL"
done
