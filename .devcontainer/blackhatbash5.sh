#!/bin/bash

# Uses the '&&' (AND) operator to create 'test123' ONLY if the creation of 'test' succeeds.
touch test && touch test123

# Uses the ';' operator to run three commands sequentially, regardless of whether the previous ones succeed or fail.
ls; ps; whoami

# Groups multiple commands using '()' so their combined output can be redirected as a single unit.
(ls; ps)

# Attempts to run 'lzl'. If it is an invalid or failing command, it triggers the fallback echo message.
lzl || echo "the lzl command failed"

# Creates or overwrites 'archivo.txt', populating it with the initial string "uno".
echo "uno" > archivo.txt

# Displays the current contents of 'archivo.txt' to the terminal ("uno").
cat archivo.txt

# Overwrites the existing content of 'archivo.txt', replacing it entirely with the string "uno-uno".
echo "uno-uno" > archivo.txt

# Displays the updated contents of 'archivo.txt' to verify the overwrite ("uno-uno").
cat archivo.txt

# Appends a new line containing the string "dos-dos" to the very end of 'archivo.txt'.
echo "dos-dos" >> archivo.txt

# Displays the final combined contents of 'archivo.txt' ("uno-uno" followed by "dos-dos").
cat archivo.txt

# Lists the root directory (/) contents in long format (-l) and redirects both standard output (stdout) 
# and standard error (stderr) into a file named 'stdout_and_stderr.txt'.
ls -l / &> stdout_and_stderr.txt

# Lists the root directory (/) in long format, explicitly routing successful output (stdout) 
# into 'stdout.txt' and any potential error messages (stderr) into 'stderr.txt'.
ls -l / 1> stdout.txt 2> stderr.txt

# Feeds the contents of 'archivo.txt' directly into the standard input (stdin) of the 'cat' command.
cat < archivo.txt

#EXPLICAR LOS TEMAS VISTOS EN EL DOCKERFILE, TAREA