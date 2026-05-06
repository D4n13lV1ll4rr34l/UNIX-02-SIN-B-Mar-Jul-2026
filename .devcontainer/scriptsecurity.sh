id:
The id command in Linux is used to display a user’s identity information, including user ID (UID), group ID (GID), and group memberships.

cat /etc/passwd|head -10 
The command cat /etc/passwd | head -10 is used to view a portion of the system’s user account file in Linux. The /etc/passwd file contains basic information about all users on the system, such as usernames, user IDs (UID), group IDs (GID), home directories, and default shells.

The cat command outputs the entire content of this file, while the pipe (|) sends that output to the head command. The head -10 part limits the result to only the first 10 lines, making it easier to quickly inspect a sample of user entries without displaying the whole file.

groups y groups $USER

The groups command in Linux shows the groups a user belongs to.

When you run groups without arguments, it displays the groups of the current user. This is useful to quickly check permissions and access levels tied to your account.

When you run groups $USER, it explicitly shows the groups for the user stored in the $USER environment variable (usually your current user). In most cases, both commands produce the same output, but groups $USER makes the target user explicit.
id -a displays all identity information for the current user (UID, GID, and all group memberships). In most systems, it is equivalent to running id without options.

id -g shows only the primary group ID (GID) of the user.


mkdir ~/proyecto_unix/

creates a new directory called proyecto_unix inside your home folder (~).

ls -la ~/proyecto_unix

lists all files inside that directory in long format, including hidden files. Since the directory was just created and is empty, it will typically only show . and .. entries, which represent the current and parent directory.

#groupadd (options) group_names
#create a simple group
sudo groupadd developers
sudo groupadd -g 2000 operations # Specific GID 
# System group (GID < 1000)
sudo groupadd --system web_services

#verifications of the creations:

grep "desarolladores\operaciones|operaciones\|servicios_web"/etc/group
grep -E "desarolladore|operaciones|servicios_web" /etc/group
# View main options
groupadd --help

#Saw the range of GIDs in the system
grep "GID_MIN\|GID_MAX\|SYS_GID" /etc/login.defs

#the groups of the GID system have less GID than the users minimum
#In ubuntu, commonly;

#SYS_GID_MIN = 100
#SYS_GID_MAX = 999
#GID_MIN = 1000
#GID_MAX = 60000

#Basic syntaxix
# addgroup (opciones) nombre_grupo
#Creation of groups with addgroup
sudo addgroup diseno
sudo addgroup --gid 2100 marketing
sudo addgroup --system cache_web
#verify
grep "diseño\/marketing\/cache_web"/etc

#saw which groups the current user is
groups
id
#add user to a group with usermod 
sudo usermod -aG desarolladores $USER
sudo usermod -aG diseno $USER

#The solution is to use whoami to solve the problem, showing that the user is root and letting the command in
#IMPORTANT: Flag -a is fundamental
#Without a, usermod is about to replace all the groups of the user, with -a adds the group manteining the existants
#verify the change
grep"desarolladores\|diseno"/etc/group

#add user to group with adduser
sudo adduser $USER marketing

#show the actual state
id $USER 
grep user /etc/group

#Create a temporal group for the demo
sudo groupadd grupo_temporal
sudo usermod -aG grupo_temporal $USER
id $USER #tiene grupo_temporal
#NOW THE MISTAKE usermod without -a
sudo usermod -G desarolladores root
id $USER 
#Restore
sudo usermod -aG diseno,marketing,grupo_temporal root
id root #restored