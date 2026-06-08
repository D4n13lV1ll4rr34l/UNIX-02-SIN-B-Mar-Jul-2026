#!/bin/bash

# This script pings any address provided as an argument.

SCRIPT_NAME="${0}"
TARGET="${1}"

echo "Running the script ${SCRIPT_NAME}..."
echo "Pinging the target: ${TARGET}..."
ping -c 3 "${TARGET}"

# Display all arguments passed to the script as a single list
echo "The arguments are: $@"

# Display the total count of arguments passed to the script
echo "The total number of arguments is: $#"