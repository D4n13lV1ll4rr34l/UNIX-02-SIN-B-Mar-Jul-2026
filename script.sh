* `umask 027`: Sets default file permissions so new files are not accessible to others and have restricted group access.
* `touch archivo2`: Creates an empty file named *archivo2* (or updates its timestamp if it exists).
* `mkdir`: Attempts to create a directory but fails because no name was provided.
* `mkdir directorio2`: Creates a new directory called *directorio2*.
* `ls -l`: Lists all files and directories in long format, showing permissions, owner, size, and date.
* `sudo apt-get update`: Updates the package list to get the latest versions available from repositories.
* `sudo apt-get install acl`: Installs the ACL package to manage advanced file permissions.
* `sudo chown -R $(whoami)`: Fails because no target file or directory was specified.
* `sudo chown -R $(whoami) .`: Changes ownership of all files in the current directory to the current user.
* `sudo setfacl -bnr .`: Attempts to remove all ACL permissions recursively, but fails due to incorrect syntax.

@D4n13lV1ll4rr34l ➜ /workspaces/UNIX-02-SIN-B-Mar-Jul-2026 (main) $ sudo apt-get update
Get:1 https://packages.microsoft.com/repos/microsoft-ubuntu-noble-prod noble InRelease [3600 B]
Get:2 http://archive.ubuntu.com/ubuntu noble InRelease [256 kB]        
Get:3 http://security.ubuntu.com/ubuntu noble-security InRelease [126 kB]
Get:4 http://archive.ubuntu.com/ubuntu noble-updates InRelease [126 kB]
Get:5 http://archive.ubuntu.com/ubuntu noble-backports InRelease [126 kB]
Get:6 https://packages.microsoft.com/repos/microsoft-ubuntu-noble-prod noble/main amd64 Packages [125 kB]
Get:7 https://packages.microsoft.com/repos/microsoft-ubuntu-noble-prod noble/main all Packages [643 B]
Get:8 http://security.ubuntu.com/ubuntu noble-security/universe amd64 Packages [1498 kB]
Get:9 http://security.ubuntu.com/ubuntu noble-security/multiverse amd64 Packages [34.2 kB]
Get:10 http://security.ubuntu.com/ubuntu noble-security/restricted amd64 Packages [3491 kB]
Get:11 http://archive.ubuntu.com/ubuntu noble/restricted amd64 Packages [117 kB]
Get:12 http://security.ubuntu.com/ubuntu noble-security/main amd64 Packages [1984 kB]
Get:13 http://archive.ubuntu.com/ubuntu noble/main amd64 Packages [1808 kB] 
Get:14 http://archive.ubuntu.com/ubuntu noble/universe amd64 Packages [19.3 MB]            
Get:15 http://archive.ubuntu.com/ubuntu noble/multiverse amd64 Packages [331 kB]
Get:16 http://archive.ubuntu.com/ubuntu noble-updates/restricted amd64 Packages [3658 kB]
Get:17 http://archive.ubuntu.com/ubuntu noble-updates/multiverse amd64 Packages [38.0 kB]
Get:18 http://archive.ubuntu.com/ubuntu noble-updates/main amd64 Packages [2354 kB]
Get:19 http://archive.ubuntu.com/ubuntu noble-updates/universe amd64 Packages [2142 kB]
Get:20 http://archive.ubuntu.com/ubuntu noble-backports/universe amd64 Packages [35.6 kB]
Get:21 http://archive.ubuntu.com/ubuntu noble-backports/multiverse amd64 Packages [671 B]
Get:22 http://archive.ubuntu.com/ubuntu noble-backports/main amd64 Packages [49.0 kB]
Fetched 37.6 MB in 3s (14.6 MB/s)                             
Reading package lists... Done
@D4n13lV1ll4rr34l ➜ /workspaces/UNIX-02-SIN-B-Mar-Jul-2026 (main) $ sudo apt-get install acl
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following NEW packages will be installed:
  acl
0 upgraded, 1 newly installed, 0 to remove and 79 not upgraded.
Need to get 39.4 kB of archives.
After this operation, 197 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu noble-updates/main amd64 acl amd64 2.3.2-1build1.1 [39.4 kB]
Fetched 39.4 kB in 0s (508 kB/s)
debconf: unable to initialize frontend: Dialog
debconf: (Dialog frontend requires a screen at least 13 lines tall and 31 columns wide.)
debconf: falling back to frontend: Readline
Selecting previously unselected package acl.
(Reading database ... 58630 files and directories currently installed.)
Preparing to unpack .../acl_2.3.2-1build1.1_amd64.deb ...
Unpacking acl (2.3.2-1build1.1) ...
Setting up acl (2.3.2-1build1.1) ...
Processing triggers for man-db (2.12.0-4build2) ...
@D4n13lV1ll4rr34l ➜ /workspaces/UNIX-02-SIN-B-Mar-Jul-2026 (main) $ sudo chown -R $(whoami)
chown: missing operand after ‘codespace’
Try 'chown --help' for more information.
@D4n13lV1ll4rr34l ➜ /workspaces/UNIX-02-SIN-B-Mar-Jul-2026 (main) $ sudo chown -R $(whoami) .
@D4n13lV1ll4rr34l ➜ /workspaces/UNIX-02-SIN-B-Mar-Jul-2026 (main) $ sudo setfacl -bnr .
Usage: setfacl [-bkndRLP] { -m|-M|-x|-X ... } file ...
Try `setfacl --help' for more information.
@D4n13lV1ll4rr34l ➜ /workspaces/UNIX-02-SIN-B-Mar-Jul-2026 (main) $ unmask 077
bash: unmask: command not found
@D4n13lV1ll4rr34l ➜ /workspaces/UNIX-02-SIN-B-Mar-Jul-2026 (main) $ unmask 0777
bash: unmask: command not found
@D4n13lV1ll4rr34l ➜ /workspaces/UNIX-02-SIN-B-Mar-Jul-2026 (main) $ unmask  027
bash: unmask: command not found
@D4n13lV1ll4rr34l ➜ /workspaces/UNIX-02-SIN-B-Mar-Jul-2026 (main) $ unmask 027
bash: unmask: command not found
@D4n13lV1ll4rr34l ➜ /workspaces/UNIX-02-SIN-B-Mar-Jul-2026 (main) $ umask 077
@D4n13lV1ll4rr34l ➜ /workspaces/UNIX-02-SIN-B-Mar-Jul-2026 (main) $ touch secreto.txt
@D4n13lV1ll4rr34l ➜ /workspaces/UNIX-02-SIN-B-Mar-Jul-2026 (main) $ mkdir privado
@D4n13lV1ll4rr34l ➜ /workspaces/UNIX-02-SIN-B-Mar-Jul-2026 (main) $ ls -l
total 148
-rw-rw-rw-  1 codespace root        632 Apr 27 12:41 Daniel_doc_cifrado.txt
-rw-rw-rw-  1 codespace root      34523 Apr 27 12:41 LICENSE
-rw-rw-rw-  1 codespace root        253 Apr 27 12:41 Practical_Wokrshop.sh
-rw-rw-rw-  1 codespace root         70 Apr 27 12:41 README.md
-rwxrwxrwx  1 codespace root      17064 Apr 27 12:41 Saludo
-rw-rw-rw-  1 codespace root         84 Apr 27 12:41 Saludo.c
-rw-rw-rw-  1 codespace root         19 Apr 27 12:41 archivo.txt
-rw-rw-rw-  1 codespace codespace     0 Apr 27 12:42 archivo2
drwxrwxrwx+ 2 codespace root       4096 Apr 27 12:41 calculadora
drwxrwxrwx+ 2 codespace codespace  4096 Apr 27 12:43 directorio2
-rw-rw-rw-  1 codespace root        724 Apr 27 12:41 doc_cifrado.txt
-rw-rw-rw-  1 codespace root        142 Apr 27 12:41 doc_no_cifrado.txt
-rw-rw-rw-  1 codespace root       1025 Apr 27 12:41 doc_no_cifrado.txt.asc
-rw-rw-rw-  1 codespace root        753 Apr 27 12:41 doc_no_cifrado.txt.gpg
-rw-rw-rw-  1 codespace root        566 Apr 27 12:41 doc_no_cifrado.txt.sig
-rw-rw-rw-  1 codespace root        178 Apr 27 12:41 filesystem.sh
-rw-rw-rw-  1 codespace root       3198 Apr 27 12:41 llave_david.asc
-rw-rw-rw-  1 codespace root       3199 Apr 27 12:41 mi_llave_.asc
drwxrwxrwx+ 2 codespace codespace  4096 Apr 27 12:49 privado
-rwxrwxrwx  1 codespace root      15960 Apr 27 12:41 saludo.bin
-rw-rw-rw-  1 codespace codespace   979 Apr 27 12:47 script.sh
-rw-rw-rw-  1 codespace root       1853 Apr 27 12:41 script_gnupg.sh
-rw-rw-rw-  1 codespace codespace     0 Apr 27 12:49 secreto.txt
-rw-rw-rw-  1 codespace root          6 Apr 27 12:41 test.txt
@D4n13lV1ll4rr34l ➜ /workspaces/UNIX-02-SIN-B-Mar-Jul-2026 (main) $ 

sudo useradd -m -s /usr/bin/zsh luna: Creates a new user luna with a home directory and Zsh as default shell.


chown luna mi_archivo: Fails because changing ownership requires superuser privileges.


sudo chown luna mi_archivo: Changes the owner of mi_archivo to user luna.

