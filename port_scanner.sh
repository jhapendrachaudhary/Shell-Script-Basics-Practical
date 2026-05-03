#!/bin/bash
# check_port.sh

if [ $# -ne 2 ]; then
    echo "Usage: $0 <host> <port>"
    echo "Example: $0 google.com 443"
    exit 1
fi

host="$1"
port="$2"

if nc -zv "$host" "$port" 2>/dev/null; then
    echo " Port $port is open on $host"
    exit 0
else
    echo " Port $port is closed or unreachable on $host"
    exit 1
fi
