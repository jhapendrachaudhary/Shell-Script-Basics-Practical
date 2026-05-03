#!/bin/bash

# Working email configuration for Gmail
THRESHOLD=80


# Get CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | sed 's/%us,//' | sed 's/%//')
CPU_PERCENT=$(echo "$CPU_USAGE")

echo "Current CPU Usage: ${CPU_PERCENT}%"

# if (( $(echo "$CPU_PERCENT < $THRESHOLD" | bc -l) )); then
    echo "ALERT: CPU usage is HIGH! Current: ${CPU_PERCENT}% (Threshold: ${THRESHOLD}%)"
    
    # Send email using STARTTLS (port 587) instead of SMTPS
    curl --url "smtp://smtp.gmail.com:587" \
         --mail-from "theunknownmen777@gmail.com" \
         --mail-rcpt "jhapendrachaudhary777@gmail.com" \
         --upload-file <(echo -e "Subject: CPU Alert - $(hostname)\n\nCPU Usage: ${CPU_PERCENT}%\nThreshold: ${THRESHOLD}%\nTime: $(date)") \
         --user "theunknownmen777@gmail.com:autkwhsllqqbiweo" \
         --ssl-reqd
    
    if [ $? -eq 0 ]; then
        echo "Email alert sent successfully!"
    else
        echo "Failed to send email via curl"
    fi
# else
#    echo "CPU usage is normal"
# fi
