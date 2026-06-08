#!/bin/bash
# Assigns the value '4' to the variable named 'result'.
let result="4"

# Prints the string to the terminal, substituting the variable '${result}' with its current value.
# Using curly braces {} is a best practice to avoid ambiguity with surrounding text.
echo "The result is ${result}"

# Prints the string to the terminal, substituting the variable '$result' with its current value using a short-hand syntax.
echo "The result is $result"

# Performs an arithmetic evaluation (8 multiplied by 8) and assigns the calculated value to 'result'.
result=$((8*8))

# Evaluates the expression (5 plus 505) using the external 'expr' command and assigns the output to 'result'.
result=$(expr 5 + 505)

# Prints the string to the terminal, substituting the variable '${result}' with its current value (510).
echo "${result}"

# Displays the reference manual (man page) for the 'expr' command, showing its usage, options, and operators.
man expr