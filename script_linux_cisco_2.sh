 Linux Cisco Course - Command Exploration
Author: DANIEL VILLARREAL
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

FILE PERMISSIONS

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

CHMOD COMMAND (CHANGE FILE PERMISSIONS)

# chmod is used to change file or directory permissions
# Only the owner or root user can modify permissions

# Syntax:
# chmod [permissions] file

# Structure:
# chmod [who][action][permissions] file

# Who:
# u -> user (owner)
# g -> group
# o -> others
# a -> all

# Actions:
# + -> add permission
# - -> remove permission
# = -> set exact permission

# Permissions:
# r -> read
# w -> write
# x -> execute

# Check current permissions
ls -l hello.sh

# Add execute permission to the owner
chmod u+x hello.sh

# Verify changes
ls -l hello.sh

# Now the file should show 'x' in owner permissions

# Run the script from the current directory
./hello.sh

# "./" means execute from the current directory

# Remove execute permission from others
chmod o-x hello.sh

# Give read and write permissions to group
chmod g+rw hello.sh

# Give execute permission to all users
chmod a+x hello.sh

# Make scripts executable
chmod u+x script.sh

# Restrict access to sensitive files
chmod o-r file.txt

CHOWN COMMAND (CHANGE FILE OWNER)

# chown is used to change the owner of a file or directory
# Changing the owner requires administrative privileges (sudo)

# Syntax:
# chown [new_owner] file

# List files with ownership details
ls -l hello.sh

# The third column shows the owner
# The fourth column shows the group

# Change owner of file to root
sudo chown root hello.sh

# Verify the change
ls -l hello.sh

# Now the owner should be 'root'

# Try to execute the script
./hello.sh

# This may fail if the owner (root) has execute permission
# but the current user does not have sufficient access

# Execute the script as root
sudo ./hello.sh


# Change group ownership (allowed for file owner)
chown :sysadmin hello.sh

# Verify group change
ls -l hello.sh


# Assign files to specific users or services
sudo chown root config.conf

# Useful in server environments for managing access control

FILE VIEWING COMMANDS (cat, head, tail)

# Display full content of a file (best for small files)
cat animals.txt

# cat = concatenate (used to display file content quickly)

# Warning:
# Not recommended for large files (too much output)


# Show first 10 lines of a file (default)
head alpha.txt

# Show first 5 lines
head -n 5 alpha.txt

# Useful for previewing file content

# Show last 10 lines of a file (default)
tail alpha.txt

# Show last 5 lines
tail -n 5 alpha.txt

# Useful for checking recent updates in files (like logs)

# Show entire file
cat alpha.txt

# Show only beginning
head alpha.txt

# Show only end
tail alpha.txt

# Preview file before editing
head file.txt

# Monitor latest entries in logs
tail /var/log/syslog

# Avoid using cat for large files

 CP COMMAND (COPY FILES)

 # cp is used to copy files or directories
# Syntax:
# cp source destination

# Copy a file to the current directory (.)
cp /etc/passwd .

# "." represents the current directory

# Verify the copy
ls

# Copy file and rename it
cp animals.txt animals_backup.txt

# Now both files exist:
ls


# Copy file into another directory
cp animals.txt ~/Documents

# Copy multiple files into a directory
cp animals.txt alpha.txt ~/Documents

# To copy a file:
# - Read (r) permission on the source file
# - Execute (x) permission on source directory
# - Write (w) + Execute (x) on destination directory

# Create backup before editing a file
cp file.txt file_backup.txt

# Copy configuration files safely
cp config.conf config.conf.bak

 DD COMMAND (LOW-LEVEL COPY)

 # dd is used for low-level copying (bit by bit)
# It can copy files, partitions, or entire disks

# Syntax:
# dd if=input_file of=output_file [options]

# Create a file filled with zeros (50 MB)
dd if=/dev/zero of=/tmp/swapex bs=1M count=50

# if = input file
# of = output file
# bs = block size
# count = number of blocks

# if -> input file (source)
# of -> output file (destination)
# bs -> block size (e.g., 1M = 1 megabyte)
# count -> number of blocks to copy

# Create a swap file
dd if=/dev/zero of=/tmp/swapfile bs=1M count=100

# Copy raw data to a file (backup example)
dd if=/dev/sda of=/tmp/backup.img

# Restore from backup
dd if=/tmp/backup.img of=/dev/sda

# dd can overwrite entire disks if used incorrectly
# Always double-check input (if) and output (of)

# Example (dangerous if wrong device is used):
# dd if=/dev/sda of=/dev/sdb

#CISCO Linux Course (part 2)

# CHAPTER 12: FILE MANAGEMENT
# Section 12.2: Moving Files
# Description: Move the file 'people.csv' into the 'Work' directory.
# The file retains its original name because no new name was specified.

cd ~/Documents
mv people.csv Work

# Verify the file was moved successfully
ls Work

# CHAPTER 13: REMOVING FILES
# Section 13.1: Removing Files and Directories
# Description: Delete a regular file ('linux.txt') using the rm command.
# Warning: In Linux, files deleted via 'rm' do not go to a trash bin; 
# they are permanently deleted from the filesystem.

touch linux.txt

# Remove the file
rm linux.txt

# Verify the file no longer exists
ls linux.txt

# Description: Attempt to delete the 'Work' directory. 
# Standard 'rm' fails on directories, so the recursive option '-r' (or '-R') 
# must be used to delete the directory along with all its contents.

# Running 'rm Work' would result in: rm: cannot remove 'Work': Is a directory
rm -r Work

# Verify the directory and its contents are completely gone
ls Work

# CHAPTER 14: INPUT FILTERING
# Description: Search for lines matching a specific pattern within a file.
# Here, we search for the pattern 'sysadmin' inside the 'passwd' file
# to isolate the account details of that specific user.

# (Ensure the file exists in your current directory before running)
# cp /etc/passwd .

grep sysadmin passwd

# Expected output format:
# sysadmin:x:1001:1001:System Administrator,,,,:/home/sysadmin:/bin/bash

# Section 14.1: Regular Expressions
# Description: Documentation of Basic and Extended Regular Expressions (Regex)
# used as patterns with the grep command to perform advanced text filtering.

# Supported by standard grep by default.
# .    -> Matches any single character
# [ ]  -> Matches any single character specified inside the brackets
# [^] -> Matches any single character NOT specified inside the brackets
# * -> Matches zero or more occurrences of the previous character
# ^    -> Anchor: Matches the pattern only at the BEGINNING of a line
# $    -> Anchor: Matches the pattern only at the END of a line

# Requires 'egrep' or 'grep -E' to function correctly.
# +    -> Matches one or more occurrences of the previous pattern
# ?    -> Matches zero or one occurrence of the previous pattern (optional)
# { }  -> Specifies exact, minimum, or maximum matches of the previous pattern
# |    -> Logical OR (Alternation)
# ( )  -> Groups patterns together

# Section 14.2: Basic Patterns
# Description: Use anchors to restrict matching to specific positions in a line.
# Patterns are enclosed in single quotes to prevent the shell from misinterpreting them.

# '^' Anchors the pattern to the BEGINNING of the line
grep '^root' passwd

# '$' Anchors the pattern to the END of the line
grep 'r$' alpha-first.txt

# Description: The dot (.) matches any single character except a newline.

# Match words containing 'r', followed by exactly two characters, ending with 'f'
grep 'r..f' red.txt

# Match words containing 'r', followed by exactly two characters, ending with 'd'
grep 'r..d' red.txt

# Match any line containing at least four consecutive characters
grep '....' red.txt

# Match lines containing any numeric character from 0 to 9
grep '[0-9]' profile.txt

# Negation: Match lines containing any NON-numeric character
# Note: This matches lines with text, even if they also contain numbers.
grep '[^0-9]' profile.txt

# Literal Dot: Inside brackets, special regex symbols lose their power.
# This searches explicitly for lines containing a literal period '.'
grep '[.]' profile.txt

# Type text dynamically and press Enter to filter. Exit using Ctrl+D.

grep 'sysadmin'

# Return to home directory after finishing exercises
cd ~

# CHAPTER 15: SYSTEM SHUTDOWN
Safely Shutting Down the System
# Description: Check system time and execute safe power-off commands.
# Administrative privileges (root/sudo) are required to execute these commands.

# Display the current system time and date in UTC format
date

# Execute an immediate shutdown of the system
sudo shutdown now

# Schedule a shutdown with a specific time delay (+minutes) 
# and broadcast a custom wall message to all logged-in users
sudo shutdown +1 "Goodbye World!"

# Cancel an active scheduled shutdown execution
sudo shutdown -c

# --- ENVIRONMENT NOTE ---
# Running 'shutdown' inside GitHub Codespaces (Docker container) results in:
# "System has not been booted with systemd as init system (PID 1). Can't operate."
# Containers do not manage hardware power states or run traditional init systems

# CHAPTER 16: NETWORK CONFIGURATION
# Description: Troubleshoot missing network utilities and execute ping tests.

# Modern interface inspection (used because ifconfig was not present)
ip address show

# --- ENVIRONMENT TROUBLESHOOTING ---
# If 'ping' returns 'command not found' in a minimal Docker/Codespace environment,
# install the required package using the advanced package tool (apt):
#
# sudo apt-get update && sudo apt-get install -y iputils-ping

# Test local loopback connectivity (4 packets)
ping -c 4 127.0.0.1

# Test external DNS resolution and routing
ping -c 4 google.com

# CHAPTER 17: PROCESS VIEWING
# Description: Monitor active system processes and examine execution metadata.
# In Linux, process tracking depends heavily on User IDs (UID) for security.

# Display processes running in the current terminal session only
# Output Fields:
#   PID: Process Identifier (unique number assigned to each running program)
#   TTY: TeleTypewriter (the terminal device controlling the process)
#   TIME: Cumulative CPU time used by the process
#   CMD: The command/executable name that started the process
ps

# Display ALL processes running across the entire operating system
ps -e

# Display a full-format (-f) listing of all (-e) system processes
# Adds critical columns:
#   UID: User ID owning the process (controls security boundaries)
#   PPID: Parent Process ID (the process that generated this one)
#   STIME: Start time of the process
ps -ef

# CHAPTER 18: PACKAGE MANAGEMENT Managing Software with APT
# Description: Execute cowsay using its absolute path.
# Note: On Ubuntu/Debian, legacy games and utilities are placed in /usr/games/
# which might be excluded from the system's default $PATH variable.

# Direct execution via absolute path
/usr/games/cowsay 'NDG Linux Unhatched'

# Alternative: Creating a terminal session alias
# alias cowsay='/usr/games/cowsay'

# Description: Search, install, update, and purge software packages in Debian-based systems.
# Note: 'apt-get' acts as a high-level front-end interface for the low-level 'dpkg' tool.

# Update the local package index cache with the remote repositories
sudo apt-get update

# Search repository package names and descriptions for a specific keyword
apt-cache search cow

# Install a software package from the repositories
sudo apt-get install -y cowsay

# Execute the installed application (enclosing string in single quotes to protect it from shell parsing)
# /usr/games/cowsay 'NDG Linux Unhatched'
cowsay 'NDG Linux Unhatched'

# Upgrade all installed packages on the system to their latest available versions
sudo apt-get upgrade -y

# Completely remove a package along with all its configuration files (purge)
# Note: 'remove' deletes the app but keeps config files; 'purge' deletes everything.
sudo apt-get purge -y cowsay

# CHAPTER 19: USER PASSWORD MANAGEMENT Updating and Viewing Password Status
# Description: Manage user account passwords and inspect shadow password aging policies.
# Note: Regular users can only change their own password. Root/sudo can change any password. (L1B3RT)

# Change the password of the currently logged-in user
# Requires entering the current password once and the new password twice (characters are hidden)
passwd

# View password status information for a specific user
# Output fields breakdown:
#   1. Username (e.g., sysadmin)
#   2. Status flags: 'P' (Usable/Password set), 'L' (Locked), 'NP' (No password)
#   3. Last modification date
#   4. Minimum days required before next change
#   5. Maximum days allowed before expiration
#   6. Warning days prior to expiration
#   7. Inactivity days allowed after expiration before account disable
passwd -S sysadmin

# Administrative execution: Root modifying another user's password without knowing the old one
# sudo passwd sysadmin

# Terminate administrative shell if active
exit

# CHAPTER 20: I/O REDIRECTION Standard Output Redirection
# Description: Learn how to redirect Standard Output (STDOUT) to create, 
# overwrite, or append content into files.
#
# Core Concepts (File Descriptors):
#   - STDIN (Standard Input): Data fed into a command (File Descriptor 0)
#   - STDOUT (Standard Output): Normal command results displayed (File Descriptor 1)
#   - STDERR (Standard Error): Error messages from failed executions (File Descriptor 2)

# Ensure workspace focus
cd /workspaces/UNIX-02-SIN-B-Mar-Jul-2026/Documents

# 1. Overwriting Redirection (>)
# Redirects STDOUT into a file. If the file exists, its content is entirely replaced.
cat food.txt > newfile1.txt
echo "I like food." > newfile1.txt

# 2. Appending Redirection (>>)
# Redirects STDOUT to the end of a file, preserving any preexisting text.
echo "This food is good." >> newfile1.txt

# Verify resulting modifications
cat newfile1.txt

# Note: Redirection requires Write (w) permissions on the target file.

# CHAPTER 21: THE VI TEXT EDITOR Modal Text Editing
# Description: Cheat sheet for vi/vim navigation, actions, and modes.
# Note: vi has three main operational states: Command Mode, Insert Mode, and Ex Mode.

# Open or create a file in vi
vi viedit.txt

# 1. COMMAND MODE (Default Mode - Press 'Esc' to return here) 

# --- Navigation (Motion) ---
# h / j / k / l   -> Left / Down / Up / Right (Alternative to arrow keys)
# w / b           -> Forward one word / Backward one word
# ^ / $           -> Move to Beginning / End of the current line
# gg / G          -> Go to First line / Go to Last line
# [number]G       -> Go to specific line number (e.g., 5G goes to line 5)
# Ctrl + G        -> Display current line info status

# dd / 3dd        -> Delete (cut) current line / Delete 3 lines
# dw              -> Delete (cut) current word
# yy / 3yy        -> Yank (copy) current line / Copy 3 lines
# p / P           -> Put (paste) buffer text AFTER cursor / BEFORE cursor

# /pattern        -> Search forward for a pattern (Press 'n' for next, 'N' for previous)
# ?pattern        -> Search backward for a pattern

# 2. INSERT MODE (Used for typing text)

# i / I           -> Insert BEFORE cursor / Insert at BEGINNING of the line
# a / A           -> Insert AFTER cursor / Insert at END of the line
# o / O           -> Open new line BELOW current line / Open new line ABOVE

# 3. EX MODE (Extended commands - Type ':' from Command Mode)
# :w              -> Write (save) changes to the filesystem
# :w filename     -> Save a copy as 'filename'
# :q              -> Quit (fails if there are unsaved changes)
# :q!             -> Force Quit discard all unsaved changes
# :wq             -> Save changes and quit (Equivalent to 'ZZ' in Command Mode)

# CHAPTER 22: NEXT STEPS AND PROFESSIONAL ROADMAP
# Description: Overview of industry certifications mapped to this training.

# Validates foundational knowledge of open-source software ecosystem (FOSS),
# basic system architecture, command-line operations, backups, and user permissions.
# Core Pillars:
#   1. The Linux Community and Open Source Careers
#   2. Finding Your Way on a Linux System
#   3. The Power of the Command Line
#   4. The Linux Operating System (Processes, Hardware, Data)
#   5. Security and File Permissions

# Advanced engineering track requiring two distinct evaluation exams:
#
# Exam 101 Core Objectives (Covered in NDG Linux I):
#   - System Architecture
#   - Linux Installation and Package Management (dpkg/apt, rpm/yum)
#   - GNU and Unix Commands (Advanced Regex, text filtering, streams)
#   - Devices, Linux Filesystems, and FHS (Filesystem Hierarchy Standard)
#
# Exam 102 Core Objectives (Covered in NDG Linux II):
#   - Shells, Scripting, and Data Management
#   - User Interfaces and Desktop Environments (X11 / Wayland / KDE)
#   - Administrative Tasks (Syslog, cron jobs, user/group modification)
#   - Essential System Services (SSH, Network Time Protocol, Logging)
#   - Networking Fundamentals (Routing, DNS, IP addressing)
#   - System Security (Firewalls, SSH keys, configuration hardening)