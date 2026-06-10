#!/bin/bash

SIGNAL_TO_STOP_FILE="stoploop"
# Name of the file that will stop the loop when it exists

while [[ ! -f "${SIGNAL_TO_STOP_FILE}" ]]; do
    # While the file does NOT exist (-f checks file existence)

    echo "The file ${SIGNAL_TO_STOP_FILE} does not yet exist..."
    # Message showing the file is still missing

    echo "Checking again in 2 seconds..."
    # Inform user about retry delay

    sleep 2
    # Wait 2 seconds before checking again
done

# This line runs when the file is found
echo "File was found! Exiting..."