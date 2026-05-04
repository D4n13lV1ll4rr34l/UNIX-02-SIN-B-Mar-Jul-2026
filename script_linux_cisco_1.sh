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