ls -a: Lists the contents of a directory (files and folders).
ls -all: Shows all files, including hidden files.
ls -a /: Lists directory contents, Includes hidden files (those starting with .) Refers to the root directory (the top-level directory in Linux)
ls -l: Shows detailed information about each file:
ls -h: Show information about files human readable
rm -rf: Deletes files or directories, Deletes directories and everything inside them, including all subfolders and files, ignores warnnings
rm -- -rf: Treats files such as arguments, not options.
ls --help: Shows the help page for the ls command, including all available options and how to use them.
man ls: Opens the full manual page for the ls command.
--depth: controls how deep a command should go when working with directories or data structures.
sudo echo "hola" >etc/etc/archivo_protegido: The command doesnt work because the > is executed by the normal user
echo "hola" | sudo tee /etc/archivo_protegido > /dev/null: Writes "hola" to the file (as root) but Does NOT print anything (output is discarded to /dev/null)
echo "hola" | sudo tee /etc/archivo_protegido: Writes "hola" to the file (as root), but it does prints "hola" on the screen
sudo sh -c 'echo' "chao" >>/etc/archivo_protegido': execute all the commmand as a root, generate the text, and adds append to the file
cat /etc/archivo_protegido
hola: Shows the content
 sudo su -: opens session as root
 echo '$HOME': 