#!/bin/bash

# 🎮 Guess the Number Game
# The computer picks a random number between 1 and 100.
# You have unlimited attempts — but it tracks how many you take!

echo "Welcome to 'Guess the Number'!"
echo "I'm thinking of a number between 1 and 100."
echo "Can you guess it?"
echo "----------------------------------------"

# Generate a random number between 1 and 100
secret=$((RANDOM % 100 + 1))
guesses=0

# Main game loop
while true; do
    # Get user input
    read -p "Enter your guess (1-100): " guess

    # Validate input: must be a number between 1 and 100
    if ! [[ "$guess" =~ ^[0-9]+$ ]] || [ "$guess" -lt 1 ] || [ "$guess" -gt 100 ]; then
        echo "Please enter a valid number between 1 and 100."
        continue
    fi

    guesses=$((guesses + 1))

    # Compare guess with secret number
    if [ "$guess" -eq "$secret" ]; then
        echo "Congratulations! You guessed it in $guesses attempt(s)!"
        break
    elif [ "$guess" -lt "$secret" ]; then
        echo "Too low! Try a higher number."
    else
        echo "Too high! Try a lower number."
    fi
done

# Ask if player wants to play again
read -p "Play again? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Re-run the script
    exec "$0"
else
    echo "Thanks for playing! Goodbye!"
fi
