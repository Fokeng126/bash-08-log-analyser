#!/bin/bash

# First, I get the log file from the user
file="$1"

# I check if the user entered a file name
if [ -z "$file" ]; then
    echo "Please provide a log file." >&2
    echo "Usage: ./loganalyse.sh access.log" >&2
    exit 1
fi

# I make sure the file exists and can be read
if [ ! -f "$file" ] || [ ! -r "$file" ]; then
    echo "File does not exist or cannot be read!" >&2
    exit 1
fi

# No need to analyse a file with nothing inside
if [ ! -s "$file" ]; then
    echo "The log file is empty. No data to analyse."
    exit 0
fi

# Display the report heading
print_header() {
    echo "=========================================="
    echo " Log report: $file"
    echo "=========================================="
}

# Count how many requests were made
requests() {
    total=$(wc -l < "$file")
    printf " Total requests ........ %s\n" "$total"
}

# Find how many different IP addresses visited
ips() {
    unique=$(awk '{print $1}' "$file" | sort -u | wc -l)
    printf " Unique visitors ....... %s\n" "$unique"
}

# Count the different status codes
status_codes() {
    two=$(awk '$9 ~ /^2/' "$file" | wc -l)
    three=$(awk '$9 ~ /^3/' "$file" | wc -l)
    four=$(awk '$9 ~ /^4/' "$file" | wc -l)
    five=$(awk '$9 ~ /^5/' "$file" | wc -l)

    printf " 2xx / 3xx ............. %s / %s\n" "$two" "$three"
    printf " 4xx / 5xx ............. %s / %s\n" "$four" "$five"
}

# Find the pages people visited most
top_pages() {
    echo ""
    echo " Top 5 pages"
    awk '{print $7}' "$file" | sort | uniq -c | sort -rn | head -5
}

# Find the IP addresses that made the most requests
top_ips() {
    echo ""
    echo " Top 5 IP addresses"
    awk '{print $1}' "$file" | sort | uniq -c | sort -rn | head -5
}

# Find which pages returned a 404 error most often
error_pages() {
    echo ""
    echo " Top 5 pages with 404 errors"
    awk '$9 == 404 {print $7}' "$file" | sort | uniq -c | sort -rn | head -5
}

# Add up the data sent and convert it into MB
data_sent() {
    total=$(awk '$10 ~ /^[0-9]+$/ {total += $10} END {print total / 1048576}' "$file")
    printf "\n Data sent .............. %.1f MB\n" "$total"
}

# Display all report results
print_header
requests
ips
status_codes
top_pages
top_ips
error_pages
data_sent
