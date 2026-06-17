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