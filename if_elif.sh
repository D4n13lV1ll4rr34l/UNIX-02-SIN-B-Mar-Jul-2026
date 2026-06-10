#!/bin/bash
#tells the system to use bash to execute this script

USER_INPUT="${1}"
# Stores the first argument

if [[ -z "${USER_INPUT}" ]]; then
    # Checks if USER_INPUT is empty (-z means zero length string)
    
    echo "You must provide an argument!"
    # Prints an error message if no argument is provided

    exit 1
    # Exits the script with error code 1 (indicates failure)
fi

if [[ -f "${USER_INPUT}" ]]; then
    # Checks if the input is a regular file

    echo "${USER_INPUT} is a file."
    # Prints message if it is a file

elif [[ -d "${USER_INPUT}" ]]; then
    # Checks if the input is a directory

    echo "${USER_INPUT} is a directory."
    # Prints message if it is a directory

else
    # Executes if neither file nor directory

    echo "${USER_INPUT} is not a file or a directory."
    # Prints message when the input does not exist
fi