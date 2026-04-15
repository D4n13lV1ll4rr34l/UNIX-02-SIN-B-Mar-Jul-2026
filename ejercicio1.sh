echo '#!bin/sh' > hola.sh: creates a script file with: #!bin/sh
echo 'echo "Hola desde mi primer script"' >> hola.sh:outputs that line as text, appends it to the file
ls -l hola.sh: shows detailed information about the file, including its permissions, owner, group, size, and last modification date.
ls -l: lists all files in the current directory with detailed information.
chmod +x hola.sh: adds execute permission to the file for all users
ls -l hola.sh: confirms the permission change to -rwxrwxrwx
./hola.sh: runs the script in the current directory.
The output Hola desde mi primer script comes from the echo command