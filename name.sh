#!/bin/bash

# 1. Accept two arguments and assign them to variables
FIRST_NAME="${1}"
LAST_NAME="${2}"

# 2. Create a new file named output.txt (clearing any old content)
> output.txt

# 3. Write the current date in DD-MM-YYYY format to output.txt
# (The '+' signs tells 'date' we are using a custom format)
date "+%d-%m-%Y" >> output.txt

# 4. Append your full name to output.txt
echo "${FIRST_NAME} ${LAST_NAME}" >> output.txt

# 5. Make a backup copy named backup.txt
cp output.txt backup.txt

# 6. Print the content of output.txt to the standard output
cat output.txt