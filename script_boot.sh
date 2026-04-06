"/home" Dis command is used to navigate to the home directory of the user 

"ls -lai" Dis command is used to list files and directories, but with more detailed information.
Output: "total 12
925742 drwxr-xr-x 2 root root 4096 Apr  6 12:34 .
918514 drwxr-xr-x 1 root root 4096 Apr  6 12:34 .." 

"sudo mkdir proyecto"" "total 12 : Dis command create a new folder name proyecto using administration power
"%stat": For checking di current directory, status and permissions
-p: create parent directories if they do not already exist
/tmp/prueba/sub1/tmp/prueba/sub2: Dis is the full path of nested folders to be created
pwd: Dis command is di full path of our current directory
man: open di manual page for commands
ls: show di names of di files an folders inna di directory.
ls -l: show detailed info
ls -la: same as -l, but include hidden files (like .git).
ls -lh: same as -l, but size display inna human-readable format
ls /etc | head -20: list di files inside /etc, then send di output to head