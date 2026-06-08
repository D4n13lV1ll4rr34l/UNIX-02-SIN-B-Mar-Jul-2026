#!/bin/bash

# Prints a message to the terminal indicating the start of a delay.
echo "Sleeping for 10 seconds..."

# Sends the sleep command to the background using the '&' operator, allowing the script to continue without waiting.
sleep 10 &

# Prints a message indicating the creation of a new file.
echo "Creating the file test123"

# Creates an empty file named 'test123' in the current working directory.
touch test123

# Prints a message indicating the deletion of the file.
echo "Deleting the file test123"

# Permanently deletes the file named 'test123'.
rm test123
