#!/bin/bash

# send-telegram.sh - Securely send messages to Telegram
# Usage: ./send-telegram.sh "Your alert message"

# Get token and chat ID from environment variables (KEEP SECRETS SAFE!)
BOT_TOKEN="8274587037:AAEzmkD2PZ5A2RdvkEBF1bLHQBgnns_5bCE"
CHAT_ID="6098115506"

if [[ -z "$BOT_TOKEN" || -z "$CHAT_ID" ]]; then
    echo "ERROR: Set TELEGRAM_BOT_TOKEN and TELEGRAM_CHAT_ID environment variables" >&2
    exit 1
fi

# Read message from argument
MESSAGE="$1"

if [[ -z "$MESSAGE" ]]; then
    echo "Usage: $0 \"Your message here\"" >&2
    exit 1
fi

# URL-encode message (handles spaces/special chars)
ENCODED_MSG=$(printf '%s' "$MESSAGE" | jq -sRr @uri)

# Send message
response=$(curl -s -o /dev/null -w "%{http_code}" \
  -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d "chat_id=${CHAT_ID}" \
  -d "text=${ENCODED_MSG}" \
  -d "parse_mode=HTML")

# Check success
if [[ "$response" == "200" ]]; then
    exit 0
else
    echo "Failed to send message (HTTP $response)" >&2
    exit 1
fi
