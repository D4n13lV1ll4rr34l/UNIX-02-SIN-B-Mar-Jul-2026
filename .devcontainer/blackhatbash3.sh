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


























