#!/bin/bash
# This function checks if the current user ID equals zero (root user)

check_if_root() {
    # Function definition: returns 0 if user is root, 1 otherwise

    if [[ "${EUID}" -eq 0 ]]; then
        # EUID (Effective User ID) equals 0 only for root user
        return 0
        # Return success (true)
    else
        return 1
        # Return failure (false)
    fi
}

# Call the function and evaluate its return status
if check_if_root; then
    # If function returns 0 (true)

    echo "User is root!"
    # Message when running as root
else
    # If function returns 1 (false)

    echo "User is not root!"
    # Message when not running as root
fi