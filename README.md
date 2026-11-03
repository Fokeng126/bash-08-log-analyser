# Bash Log Analyser

## Description

This project is a Bash script that reads server log files and shows useful information about website visits, IP addresses, errors, and data usage.

## Features

- Shows the total number of requests.
- Counts unique IP addresses.
- Shows the number of successful requests and errors.
- Displays the top 5 most visited pages.
- Displays the top 5 IP addresses.
- Shows the top 5 pages that returned 404 errors.
- Calculates the total data sent.

## Requirements

- Linux terminal
- Bash
- AWK
- Basic command-line tools

## How to Use

1. Clone the repository.
2. Open the project folder in your terminal.
3. Give the script permission to run:

   ```bash
   chmod +x loganalyse.sh
   ```

4. Run the script with a log file:

   ```bash
   ./loganalyse.sh access.log
   ```

## Project Structure

```text
bash-08-log-analyser/
├── loganalyse.sh
├── README.md
├── assets/
│   └── images/
└── .github/
    └── workflows/
        └── linter.yml
```

## Author

Joshua Kroos
