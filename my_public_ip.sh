#!/bin/bash

# my_public_ip.sh
# Display your public (external) IP address

# List of trusted, simple IP echo services
SERVICES=(
  "https://api.ipify.org"
  "https://ipecho.net/plain"
  "https://ident.me"
  "https://ifconfig.me"
  "https://ipinfo.io/ip"
)

get_public_ip() {
    for svc in "${SERVICES[@]}"; do
        echo "Trying $svc..." >&2
        ip=$(curl -s --max-time 5 "$svc")
        if [[ $? -eq 0 && $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            echo "$ip"
            return 0
        fi
    done
    echo "❌ Failed to retrieve public IP from all services." >&2
    return 1
}

# Call the function
IP=$(get_public_ip)
if [ $? -eq 0 ]; then
    echo "🌍 Your public IP is: $IP"
else
    exit 1
fi
