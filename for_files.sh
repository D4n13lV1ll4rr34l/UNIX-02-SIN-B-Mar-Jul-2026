#!/bin/bash

# Loop through all files in the current directory matching the pattern "example_file*"
for file in example_file*; do
    
    # Check if the current file name is exactly "example_file1"
    if [[ "${file}" == "example_file1" ]]; then
        echo "Skipping the first file"
        # Skip the rest of this iteration and move to the next file
        continue
    fi
    
    # Write a random number into the current file (overwriting its content)
    echo "${RANDOM}" > "${file}"

done