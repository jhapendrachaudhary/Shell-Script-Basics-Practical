#!/bin/bash

# Script: check_memory.sh
# Purpose: Display memory and swap usage in human-readable format

echo "=== Memory and Swap Usage ==="
echo

# Get memory info
total_mem=$(free -h | awk '/^Mem:/ {print $2}')
used_mem=$(free -h | awk '/^Mem:/ {print $3}')
free_mem=$(free -h | awk '/^Mem:/ {print $4}')
available_mem=$(free -h | awk '/^Mem:/ {print $7}')

# Get swap info
total_swap=$(free -h | awk '/^Swap:/ {print $2}')
used_swap=$(free -h | awk '/^Swap:/ {print $3}')
free_swap=$(free -h | awk '/^Swap:/ {print $4}')

# Display results
echo "Memory:"
echo "  Total:    $total_mem"
echo "  Used:     $used_mem"
echo "  Free:     $free_mem"
echo "  Available: $available_mem"
echo
echo "Swap:"
echo "  Total:    $total_swap"
echo "  Used:     $used_swap"
echo "  Free:     $free_swap"
