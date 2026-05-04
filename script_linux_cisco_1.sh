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

# Changes the current working directory
cd Documents

# After running this command, the terminal prompt updates:
# ~/Documents

# "/" represents the root directory (top of the filesystem)
cd /

# Moves directly to the root directory

# Absolute paths start from the root directory (/)
# Example:
cd /home/sysadmin

# This always takes you to the same location regardless of your current directory

# Verify location
pwd

# Relative paths start from the current directory
# Example:
cd Documents

# Navigating through multiple directories
cd School/Art

# Equivalent to:
cd School
cd Art

# Print the current directory to confirm navigation
pwd

# Move to parent directory (one level up)
cd ..

# Move to current directory (not very useful for cd but important for other commands)
cd .

# Move to home directory from anywhere
cd ~

# Equivalent to:
cd /home/sysadmin


# Quickly return to home directory
cd ~

# Navigate step by step safely
cd Documents
cd School
cd Art

# Or directly using relative path
cd Documents/School/Art

LS COMMAND (LIST FILES AND DIRECTORIES)


# Lists files in the current directory
ls

# Lists files in a specific directory
ls /var/log

# Displays detailed information about files
ls -l

# Example with directory
ls -l /var/log

# Output fields explanation:
# - File type (-, d, l, etc.)
# - Permissions (rwx)
# - Number of links
# - Owner
# - Group
# - File size
# - Last modification date
# - File name

# -  -> regular file
# d  -> directory
# l  -> symbolic link
# c  -> character device
# b  -> block device
# p  -> pipe
# s  -> socket

# Sort files by modification time (newest first)
ls -lt

# Sort files by size (largest first)
ls -lS

# Reverse the sorting order
ls -lr

# Combine sorting options
ls -lSr

# Lists files in /var/log sorted by time
ls -lt /var/log

# Lists files in /var/log sorted by size (smallest first)
ls -lSr /var/log

# Find most recently modified files
ls -lt

# Find largest files in a directory
ls -lS

# Useful for analyzing logs in /var/log
ls -lt /var/log

ADMINISTRATIVE ACCESS (su and sudo)

# Some Linux commands require administrative privileges (root access)
# This helps protect the system from unauthorized or dangerous actions

# Switch to root user (login shell)
su -

# Alternative forms:
su -l
su --login

# Return to the previous user (exit root session)
exit

# Prompt returns to:
# sysadmin@localhost:~$

# Execute a command with administrative privileges without switching users
sudo ls

# Example: running a restricted command
sudo sl

# After entering the password, the command runs as root,
# but you remain as the normal user

# su -> opens a new shell as another user (usually root)
# sudo -> runs a single command as another user

# Use sudo for safer administrative actions
sudo ls /root

# Avoid staying logged in as root unnecessarily
# This reduces the risk of accidental system damage

# List file permissions using long format
ls -l hello.sh

# Example output:
# -rw-r--r-- 1 sysadmin sysadmin 647 Dec 20 2017 hello.sh

# The permission string is divided into 4 parts:
# [type][owner][group][others]

# Example:
# -rw-r--r--

# First character = file type:
# -  -> regular file
# d  -> directory

# rw- -> owner permissions
# r-- -> group permissions
# r-- -> others permissions

# Owner: user who created the file
# Group: users in the same group
# Others: all other users

# r (read)    -> read file content
# w (write)   -> modify file
# x (execute) -> run file as a program

# Files:
# r -> read content
# w -> modify content
# x -> execute file

# Directories:
# r -> list files
# w -> add/remove files
# x -> enter directory (cd)


# Show permissions of a file
ls -l hello.sh

# Show permissions of current directory
ls -l

# If you are the owner of the file,
# only the owner permissions apply

# Even if you belong to the group,
# group permissions will NOT be used

