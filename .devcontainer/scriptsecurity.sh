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
