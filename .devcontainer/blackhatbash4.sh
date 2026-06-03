#!/bin/bash
# Assigns the value '4' to the variable named 'result'.
let result="4"

# Prints the string to the terminal, substituting the variable '${result}' with its current value.
# Using curly braces {} is a best practice to avoid ambiguity with surrounding text.
echo "The result is ${result}"

# Prints the string to the terminal, substituting the variable '$result' with its current value using a short-hand syntax.
echo "The result is $result"

