 Linux Cisco Course - Command Exploration
Author: [Your Name]
Description: This script documents Linux commands learned
in the Cisco NetAcad "Linux Unhatched" course.
BASIC COMMAND SYNTAX
# Lists files and directories in the current directory
ls

# Lists all files including hidden ones (those starting with .)
ls -a

# Lists files in long format (permissions, owner, size, date)
ls -l

# Combines options: shows all files in long format
ls -la

# Correct usage (lowercase)
ls
# ls -lt -> sorts files by modification time (newest first)
ls -lt

# ls -lh -> shows file sizes in human-readable format (KB, MB)
ls -lh

# Real-world use:
# ls -la is useful for debugging hidden configuration filesgit add script_linux_cisco_1.sh
ARGUMENTS IN COMMANDS
# Arguments specify what the command should act upon
# General syntax:
# command [options] [arguments]

# Example: listing the contents of a specific directory
ls Documents

# This command lists all files inside the "Documents" directory
# instead of the current working directory
# Lists files inside Downloads directory
ls Downloads

# Lists files inside a specific path
ls /home/sysadmin/Documents
# Combining options and arguments
# Lists all files (including hidden ones) in Documents in long format
ls -la Documents

# Real-world use:
# Using arguments allows you to inspect directories without changing location
# This is useful when managing multiple folders quickly

OPTIONS IN COMMANDS
# Options modify the behavior of a command
# They are usually preceded by a hyphen (-)

# Example: long listing format
ls -l

# This displays detailed information such as:
# permissions, owner, file size and modification date

# Lists files in reverse alphabetical order
ls -r

# Combines long format and reverse order
ls -lr

# Same result using separate options
ls -l -r

# Multiple options can be combined into one
# This is equivalent:
ls -rl

# Lists all files (including hidden ones) in long format, reversed order
ls -lar

# Real-world use:
# Combining options helps customize output efficiently,
# especially when analyzing large directories
# Some commands use -v (verbose) to show more detailed output
# Example with aptitude (may not work in all environments)


aptitude -v moo
aptitude -vv moo
aptitude -vvv moo

# Each additional -v increases verbosity level

# Alternative way (equivalent)
aptitude -v -v moo

PWD COMMAND (PRINT WORKING DIRECTORY)
# Prints the current working directory (your current location in the filesystem)
pwd

# Example output:
# /home/sysadmin

# This means the user is currently inside their home directory

# The path shown by pwd represents the absolute location in the filesystem
# Example:
# /home/sysadmin/Documents

# "/" represents the root directory (top of the filesystem)

# The symbol "~" represents the user's home directory
# Example:
# ~ = /home/sysadmin

# You may see it in the terminal prompt:
# sysadmin@localhost:~$

# Check your current location before performing file operations
pwd

# Useful when navigating between multiple directories
# Helps avoid mistakes like deleting or editing wrong files

TERMINAL PROMPT AND CURRENT DIRECTORY

# The terminal prompt shows useful information, including:
# - Username
# - Hostname
# - Current working directory

# "~" represents the home directory
# Equivalent to:
# /home/sysadmin

# The prompt helps you quickly identify your current location
# without needing to run the pwd command every time

# Useful for:
# - Avoiding mistakes (like deleting files in the wrong directory)
# - Navigating complex directory structures
