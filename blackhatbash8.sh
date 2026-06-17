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