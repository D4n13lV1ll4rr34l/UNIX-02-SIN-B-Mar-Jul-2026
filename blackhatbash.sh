#!/bin/bash -x

# Displays the installed GNU Bash shell version and build details.
bash --version

# Lists all active global environment variables (e.g., SHELL, LANG, PWD).
env

# Returns a pseudo-random integer between 0 and 32767.
echo ${RANDOM}

# Identifies the current operating system environment (e.g., linux-gnu).
echo ${OSTYPE}

# Lists all active processes (-e) with full details (-f) like PID and PPID.
ps -e -f

# Identical to 'ps -e -f' (lists all active processes in full format).
ps -ef

# Shows disk space usage of all filesystems in readable units (GB, MB).
df --human-readable

# Starts Bash in restricted mode (--restricted) to run the specified script.
bash -x .devcontainer/blackhatbash.sh

# Turns on debug mode (prints each command and its arguments as they are executed).
set -x

# Turns off debug mode (stops printing commands during execution).
set +x
