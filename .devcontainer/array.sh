#!/bin/bash

# Sets an array named 'IP_ADDRESSES' with three distinct IP address elements.
IP_ADDRESSES=(192.168.1.1 192.168.1.2 192.168.1.3)

# Prints all elements in the array as a single space-separated string.
echo "${IP_ADDRESSES[*]}"

# Prints only the first element in the array, using 0-based indexing.
echo "${IP_ADDRESSES[0]}"

# Grants 'execute' (x) permissions exclusively to the 'user' (u) who owns the script file 'array.sh'.
chmod u+x array.sh

# Executes the 'array.sh' script from the current working directory (./).
./array.sh

