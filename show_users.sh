#!/bin/bash

# show-users.sh
# Display currently logged-in users with multiple methods

echo "🖥️ Currently Logged-In Users"
echo "============================"

# 1. Basic list (like 'users' but prettier)
echo -e "\n🔹 Simple user list:"
users | tr ' ' '\n' | sort -u

# 2. Full details with 'who'
echo -e "\n🔹 Detailed session info (who):"
who

# 3. Live activity (what users are doing)
echo -e "\n🔹 Active processes (w):"
w

# 4. On systemd systems (Ubuntu 24.04 uses systemd)
if command -v loginctl &> /dev/null; then
    echo -e "\n🔹 Systemd session info:"
    loginctl list-sessions --no-legend
fi

echo -e "\n Done."
