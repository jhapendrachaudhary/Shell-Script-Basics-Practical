#!/bin/bash

# execution_timer.sh
# Purpose: Measure and log execution time of a command or code block

# Log file (optional)
LOG_FILE="/tmp/execution.log"

# Function to log with timestamp
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# Start timer
start_time=$(date +%s.%N)

# -----------------------------
# YOUR COMMAND OR SCRIPT BLOCK GOES HERE
# -----------------------------
# Example: Simulate work with a sleep
sleep 2
# Or run a real command like:
# rsync -av /source/ /dest/
# python3 my_script.py
# -----------------------------

# End timer
end_time=$(date +%s.%N)

# Calculate elapsed time (in seconds, with decimal precision)
elapsed_time=$(echo "$end_time - $start_time" | bc)

# Log result
log "Script execution completed in $elapsed_time seconds."
