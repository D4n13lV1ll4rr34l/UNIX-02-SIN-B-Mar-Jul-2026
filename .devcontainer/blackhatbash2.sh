#!/bin/bash

# Turns on debug mode (prints each command and its arguments preceded by a '+' as they are executed).
set -x 

# Creates a new directory named 'mydirectory' in the current location.
mkdir mydirectory

# Creates an empty file named 'myfile' inside 'mydirectory' (or updates its timestamp if it already exists).
touch mydirectory/myfile

# Lists the contents of 'mydirectory' in long format (-l), showing permissions, size, and modification date.
ls -l mydirectory

# Throws an error because 'set n' is invalid syntax; you likely meant 'set -n' (reads commands without executing them) or it's a typo.
set n

# Turns off debug mode (stops printing commands during execution).
set +x