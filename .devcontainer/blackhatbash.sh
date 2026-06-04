#!/bin/bash

# 1. VARIABLES AND DECLARATIONS WITH 'let'
# The 'let' command is used to evaluate arithmetic expressions and explicitly 
# assign values to variables. Here, it assigns the string/integer '4'.
let result="4"

# To access a variable's value, the '$' sign is used.
# Using curly braces '${variable}' is the formal and recommended syntax. 
# It prevents ambiguities if text is concatenated immediately after the name.
echo "The result is ${result}"

# This is the short-hand syntax. It works exactly the same way,
# but it can cause errors if continuous text is mistaken for part of the variable name.
echo "The result is $result"

# The $(( )) structure allows native arithmetic operations inside Bash 
# without invoking external commands. This method is faster and more efficient.
# Here, it multiplies 8 by 8 (64) and stores the outcome in the 'result' variable.
result=$((8*8))

# '$(command)' executes a subprocess, captures its standard output, and substitutes it here.
# 'expr' is a classic external Unix command used to evaluate expressions.
# Note: It requires mandatory spaces between operators (5 + 505).
result=$(expr 5 + 505)

# Prints the updated value of the variable (which is now 510).
echo "${result}"

# 'man' displays the reference manual page for system commands.
# In this case, it opens the complete manual for the 'expr' external command.
man expr

# The '<<' operator redirects multiple lines of text directly into the 
# standard input (stdin) of a command (in this case, the 'cat' command).
# It acts like a temporary in-memory file, preserving line breaks and whitespace.
# 'EOF' (End Of File) serves as the delimiter marking the start and end of the block.

cat << EOF
Black Hat Bash
by No Starch Press
EOF

# The pipe operator '|' connects processes: it takes the standard output (stdout) 
# of the command on its left and feeds it directly as the standard input (stdin) 
# to the command on its right.
#
# Practical example from page 44:
# 1. 'ls -l /' -> Lists the contents of the root directory in long format.
# 2. '|' -> Routes that list to the next command without saving it to disk.
# 3. 'grep "bin"' -> Filters and displays only the lines containing the word "bin".

ls -l / | grep "bin"