#!/bin/bash

# Assigns the string value 'black hat bash' to the variable named 'book'.
book="black hat bash"

# Prints the string to the terminal, substituting the variable '${book}' with its current value.
echo "This book's name is ${book}

# Prints the string to the terminal, substituting the variable '$book' with its current value using a short-hand syntax.
echo "This book's name is $book"

# Executes 'ls -ld /' to get root directory details and stores the output string in 'root_directory'.
root_directory=$(ls -ld /)

# Prints the stored root directory metadata to the terminal using the variable's value.
echo "${root_directory}"

# Assigns the string value 'Black Hat Bash' to the variable named 'book'.
book="Black Hat Bash"

# Removes (unsets) the 'book' variable from the shell environment, deleting its value.
unset book

# Prints the variable to the terminal, resulting in a blank line because 'book' no longer exists.
echo "${book}"
















