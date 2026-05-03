#!/bin/bash

# Script: list_processes.sh
# Description: Lists all running processes with various formatting options
# Author: System Administrator
# Date: $(date +%Y-%m-%d)

echo "=== System Process Monitor ==="
echo "Generated on: $(date)"
echo "Hostname: $(hostname)"
echo "Current User: $(whoami)"
echo

# Function to display menu
show_menu() {
    echo "Select an option:"
    echo "1. Basic process list (ps aux)"
    echo "2. Tree view of processes (pstree)"
    echo "3. Top 10 CPU-consuming processes"
    echo "4. Top 10 memory-consuming processes"
    echo "5. Processes by current user"
    echo "6. Search for specific process"
    echo "7. Real-time process monitor (top - limited view)"
    echo "8. Exit"
    echo
}

# Function to list all processes (ps aux)
list_all_processes() {
    echo "=== All Running Processes ==="
    echo "Format: USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND"
    echo
    ps aux
    echo
    echo "Total processes: $(ps aux | wc -l)"
}

# Function to show process tree
show_process_tree() {
    echo "=== Process Tree View ==="
    if command -v pstree &> /dev/null; then
        pstree -p
    else
        echo "pstree command not available. Showing hierarchical ps instead:"
        ps -ejH
    fi
    echo
}

# Function to show top CPU processes
top_cpu_processes() {
    echo "=== Top 10 CPU-Consuming Processes ==="
    ps aux --sort=-%cpu | head -11
    echo
}

# Function to show top memory processes
top_memory_processes() {
    echo "=== Top 10 Memory-Consuming Processes ==="
    ps aux --sort=-%mem | head -11
    echo
}

# Function to show user processes
user_processes() {
    current_user=$(whoami)
    echo "=== Processes Owned by User: $current_user ==="
    ps -u $current_user
    echo
}

# Function to search for specific process
search_process() {
    echo -n "Enter process name to search: "
    read process_name
    echo
    echo "=== Searching for processes containing: '$process_name' ==="
    ps aux | grep -i "$process_name" | grep -v "grep"
    if [ $? -eq 1 ]; then
        echo "No processes found matching '$process_name'"
    fi
    echo
}

# Function for real-time monitoring
real_time_monitor() {
    echo "=== Real-time Process Monitor (Press 'q' to quit) ==="
    echo "This will run 'top' for 10 seconds then return to menu"
    sleep 2
    timeout 10s top -b -n 1
    echo
}

# Main script logic
while true; do
    show_menu
    echo -n "Enter your choice (1-8): "
    read choice
    echo
    
    case $choice in
        1)
            list_all_processes
            ;;
        2)
            show_process_tree
            ;;
        3)
            top_cpu_processes
            ;;
        4)
            top_memory_processes
            ;;
        5)
            user_processes
            ;;
        6)
            search_process
            ;;
        7)
            real_time_monitor
            ;;
        8)
            echo "Exiting process monitor. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please enter a number between 1-8."
            ;;
    esac
    
    echo -n "Press Enter to continue..."
    read
    clear
done
