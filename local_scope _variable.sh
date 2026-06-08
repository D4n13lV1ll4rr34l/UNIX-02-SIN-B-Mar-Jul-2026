#!/bin/bash

# Assigns a global string value to the variable named 'PUBLISHER'.
PUBLISHER="No Starch Press"

# Defines a function named 'print_name' to demonstrate local variable scope.
print_name(){
    # Declares 'name' as a local variable, restricting its availability to this function.
    local name
    
    # Assigns the string value 'Black Hat Bash' to the local variable 'name'.
    name="Black Hat Bash"
    
    # Prints the book name and publisher by substituting both variables.
    echo "${name} by ${PUBLISHER}"
}

# Invokes the 'print_name' function to execute its internal block.
print_name

# Attempts to print '${name}', resulting in an incomplete message because the variable was local to the function.
echo "Variable ${name} will not be printed because it is a local variable."

# Global Variable: A variable that is accessible anywhere within the script after it is defined. In Bash, all variables are global by default, even if they are created inside a function.
# Local Variable: A variable whose visibility and lifetime are restricted to the function where it was created. It is declared using the local keyword inside a function and is destroyed once the function finishes executing.
# Documented Bash Script: A script that includes comments (#) to explain the purpose of the code, how functions operate, and how variables behave throughout the execution flow.