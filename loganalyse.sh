#!/bin/bash

# First, I get the log file from the user
file="$1"

# I check if the user entered a file name
if [ -z "$file" ]; then
    echo "Please provide a log file."
    echo "Usage: ./loganalyse.sh access.log"
    exit 1
fi

# I make sure the file exists and can be read
if [ ! -f "$file" ] || [ ! -r "$file" ]; then
    echo "File does not exist or cannot be read!"
    exit 1
fi

# No need to analyse a file with nothing inside
if [ ! -s "$file" ]; then
    echo "The log file is empty. No data to analyse."
    exit 0
fi

# Count how many requests were made
requests() {
    echo "Total requests:"
    wc -l < "$file"
}

# Find how many different IP addresses visited
ips() {
    echo "Unique IP addresses:"
    awk '{print $1}' "$file" | sort -u | wc -l
}

# Checking how many requests were successful or had errors
status_codes() {
    echo "2xx requests:"
    awk '$9 ~ /^2/' "$file" | wc -l

    echo "3xx requests:"
    awk '$9 ~ /^3/' "$file" | wc -l

    echo "4xx requests:"
    awk '$9 ~ /^4/' "$file" | wc -l

    echo "5xx requests:"
    awk '$9 ~ /^5/' "$file" | wc -l
}

# Finding pages people visited most
top_pages() {
    echo "Top 5 pages:"
    awk '{print $7}' "$file" | sort | uniq -c | sort -rn | head -5
}

# Find the IP addresses that made the most requests
top_ips() {
    echo "Top 5 IP addresses:"
    awk '{print $1}' "$file" | sort | uniq -c | sort -rn | head -5
}

# Find which pages returned a 404 error most often
error_pages() {
    echo "Top 5 pages with 404 errors:"
    awk '$9 == 404 {print $7}' "$file" | sort | uniq -c | sort -rn | head -5
}

# Add up the data sent and convert it into MB
data_sent() {
    echo "Total data sent in MB:"
    awk '$10 ~ /^[0-9]+$/ {total += $10} END {printf "%.1f MB\n", total / 1048576}' "$file"
}

      # show all results .
      echo "SERVER LOG REPORT"
      echo "-----------------"

requests
ips

echo ""
status_codes

echo ""
top_pages

echo ""
top_ips

echo ""
error_pages

echo ""
data_sent
