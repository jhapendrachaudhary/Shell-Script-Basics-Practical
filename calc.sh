#!/bin/bash

# Simple Calculator in Bash
# Supports: +, -, *, /

echo "Simple Calculator"
echo "Supported operations: + (add), - (subtract), * (multiply), / (divide)"
echo "------------------------"

# 1. Get first number
read -p "Enter first number: " num1

# 2. Get operator
read -p "Enter operator (+, -, *, /): " op

# 3. Get second number
read -p "Enter second number: " num2

# 4. Validate that inputs are numbers (basic check)
if ! [[ "$num1" =~ ^-?[0-9]+\.?[0-9]*$ ]] || ! [[ "$num2" =~ ^-?[0-9]+\.?[0-9]*$ ]]; then
    echo "Error: Please enter valid numbers."
    exit 1
fi

# 5. Perform calculation based on operator
case "$op" in
    "+")
        result=$(echo "$num1 + $num2" | bc -l)
        ;;
    "-")
        result=$(echo "$num1 - $num2" | bc -l)
        ;;
    "*")
        result=$(echo "$num1 * $num2" | bc -l)
        ;;
    "/")
        # Check for division by zero
        if (( $(echo "$num2 == 0" | bc -l) )); then
            echo "Error: Division by zero is not allowed."
            exit 1
        fi
        result=$(echo "$num1 / $num2" | bc -l)
        ;;
    *)
        echo "Error: Unsupported operator '$op'. Use +, -, *, or /"
        exit 1
        ;;
esac

# 6. Remove trailing zeros (e.g., 5.0 → 5, 3.50 → 3.5)
result=$(echo "$result" | sed 's/\.0*$//' | sed 's/\.\([0-9]*[1-9]\)0*$/.\1/')

# 7. Display result
echo "------------------------"
echo "Result: $num1 $op $num2 = $result"
