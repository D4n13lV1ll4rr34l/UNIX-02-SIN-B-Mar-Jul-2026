#!/bin/bash

# Extracts and displays the first field from each line in log.txt.
# The first field contains the source IP address of each log entry.
awk '{print $1}' log.txt



# Extracts and displays the first three fields from each line in log.txt.
# These fields typically include the IP address and the initial timestamp information.
awk '{print $1,$2,$3}' log.txt



# Extracts and displays the first and last fields from each line in log.txt.
# $1 refers to the first field, while $NF refers to the last field in the record.
awk '{print $1,$NF}' log.txt



# Extract and display the first column from a comma-separated values (CSV) file.
# The -F',' option sets the field delimiter to a comma, allowing awk to
# correctly parse and process CSV-formatted records.
awk -F',' '{print $1}' example_csv.txt



# Display the first lines of the log file to perform a quick inspection
# of the recorded HTTP requests, source IP addresses, timestamps,
# requested resources, response codes, and user-agent information.
head log.txt

# Replace every occurrence of the string "Mozilla" with "Godzilla"
# throughout the log file output. The 'g' flag ensures that all
# matches on each line are replaced, not just the first occurrence.
sed 's/Mozilla/Godzilla/g' log.txt

# Filter log entries originating from the IP address 42.236.10.117
# and extract the seventh field, which corresponds to the requested
# resource or URL path in the Apache access log format.
grep "42.236.10.117" log.txt | awk '{print $7}'

# Replace all occurrences of the string "Mozilla" with "Godzilla"
# and save the modified output to a new file named newlog.txt.
# The original log.txt file remains unchanged.
sed 's/Mozilla/Godzilla/g' log.txt > newlog.txt

# Verify that all occurrences of "Mozilla" were replaced with "Godzilla"
# by searching for the new string in the modified log file.
grep "Godzilla" newlog.txt

# Resume job number 1 (previously suspended or sent to background)
# and bring it to the foreground so it becomes the active process.
fg %1

# Pause execution for 100 seconds.
# During this time, the shell waits without executing other commands
# in the current session unless interrupted.
sleep 100