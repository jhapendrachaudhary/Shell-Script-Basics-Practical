#!/bin/bash

# Script: main_menu.sh
# Purpose: Demonstrate user-friendly menu using 'select'
# Author: System Admin
# Date: $(date +%Y-%m-%d)

# Set menu prompt
PS3="Choose an option (1-5): "

# Define menu options
options=(
    "Check System Uptime"
    "View Disk Usage"
    "Show Running Processes (Top 10)"
    "Ping a Website"
    "Exit"
)

# Main menu loop
while true; do
    clear
    echo "╔══════════════════════════════╗"
    echo "║   SYSTEM TOOLS MENU      ║"
    echo "╚══════════════════════════════╝"
    echo

    # Display menu using 'select'
    select opt in "${options[@]}"; do
        case $REPLY in
            1)
                echo -e "\n System Uptime:"
                uptime
                ;;
            2)
                echo -e "\n Disk Usage (Top 5 directories):"
                df -h
                echo -e "\n Largest directories in /home:"
                du -sh /home/* 2>/dev/null | sort -hr | head -5
                ;;
            3)
                echo -e "\n Top 10 CPU-consuming processes:"
                ps -eo pid,ppid,user,%cpu,comm --sort=-%cpu | head -11 | column -t
                ;;
            4)
                echo -n "Enter website to ping (e.g., google.com): "
                read website
                if [[ -n "$website" ]]; then
                    echo -e "\n Pinging $website..."
                    if ping -c 3 -W 3 "$website" > /dev/null 2>&1; then
                        echo " $website is reachable!"
                    else
                        echo " $website is NOT reachable."
                    fi
                else
                    echo " No website entered."
                fi	
                ;;
            5)
                echo -e "\n Goodbye! Have a great day!\n"
                exit 0
                ;;
            *)
                echo " Invalid option. Please select 1–5."
                sleep 2
                continue 2  # Go back to outer while loop (refresh menu)
                ;;
        esac
        break  # Exit 'select' loop after handling choice
    done

    echo
    read -p "Press Enter to return to menu..."
done
