#!/bin/bash

# Extracts and displays the first field from each line in log.txt.
# Behavior:
# - Prints only column $1 (IP address in Apache log format).
# - Output is written to STDOUT.
awk '{print $1}' log.txt


# Extracts and displays the first three fields from each line in log.txt.
# Behavior:
# - Prints $1, $2, and $3 from each line.
# - Typically corresponds to IP + timestamp fragments depending on format.
awk '{print $1,$2,$3}' log.txt


# Extracts and displays the first and last fields from each record.
# Behavior:
# - $1 = first field (IP address)
# - $NF = last field (user-agent or closing token depending on log structure)
awk '{print $1,$NF}' log.txt


# Extract first column from a CSV file using comma as delimiter.
# Behavior:
# - -F',' sets comma as field separator.
# - Prints only first column of each row.
awk -F',' '{print $1}' example_csv.txt


# Displays the first 10 lines of the log file (default head behavior).
# Behavior:
# - Useful for quick inspection of file structure and formatting.
# - Does not modify the file.
head log.txt


# Replace all occurrences of "Mozilla" with "Godzilla".
# Behavior:
# - Stream editor transformation (sed).
# - Only affects output; original file remains unchanged.
sed 's/Mozilla/Godzilla/g' log.txt


# Filters logs by IP and extracts the 7th field.
# Behavior:
# - grep selects matching lines for the IP 42.236.10.117.
# - awk extracts field $7 (requested resource path in Apache logs).
grep "42.236.10.117" log.txt | awk '{print $7}'


# Replace "Mozilla" with "Godzilla" and save output to a new file.
# Behavior:
# - Output redirection (>) creates/overwrites newlog.txt.
# - Original log.txt is not modified.
sed 's/Mozilla/Godzilla/g' log.txt > newlog.txt


# Verify replacement by searching for "Godzilla".
# Behavior:
# - If output appears, replacement was successful.
# - No output = no matches found.
grep "Godzilla" newlog.txt


# Bring job 1 to foreground execution.
# Behavior:
# - Resumes suspended/background job %1.
# - Terminal is blocked until job finishes or is interrupted.
fg %1


# Pause execution for 10 seconds.
# Behavior:
# - Shell waits with no output.
# - Execution resumes after timeout.
sleep 10