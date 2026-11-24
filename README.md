
# Bash-08 Log Analyser

## Problem Statement

Server administrators need to understand website activity by checking server logs. Reading large log files manually takes time and makes it difficult to identify visitors, popular pages, errors, and data usage.

## Project Goal

The goal of this project is to create a Bash script that analyses a web server log file and produces a simple report.

## Tech Stack

- Bash
- AWK
- Linux command-line tools

## Screenshots

A screenshot of the generated log analysis report can be added here.

## Features

- Counts the total number of requests.
- Finds the number of unique visitors.
- Counts 2xx, 3xx, 4xx, and 5xx status codes.
- Displays the top 5 most visited pages.
- Displays the top 5 IP addresses.
- Finds the top 5 pages that returned 404 errors.
- Calculates the total data sent in MB.
- Handles missing filenames, missing files, and empty log files.

## Installation and Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/Fokeng126/bash-08-log-analyser.git
   ```

2. Enter the project folder:

   ```bash
   cd bash-08-log-analyser
   ```

3. Give the analyser permission to run:

   ```bash
   chmod +x loganalyse.sh
   ```

4. Generate the sample log using the provided generator:

   ```bash
   chmod +x make-sample-log.sh
   ./make-sample-log.sh > access.log
   ```

5. Run the analyser:

   ```bash
   ./loganalyse.sh access.log
   ```

## Sample Report

The following report was generated using the official Appendix F sample log containing 5,000 lines.

```text
==========================================
 Log report: access.log
==========================================
 Total requests ........ 5000
 Unique visitors ....... 10
 2xx / 3xx ............. 3932 / 177
 4xx / 5xx ............. 794 / 97

 Top 5 pages
   1004 /index.html
    613 /css/style.css
    375 /apply
    351 /blog/bash-tips
    349 /about.html

 Top 5 IP addresses
    513 154.73.4.200
    512 41.202.219.70
    508 41.211.10.8
    505 102.244.1.9
    500 154.72.160.3

 Top 5 pages with 404 errors
    351 /blog/bash-tips
    312 /old-page
     27 /index.html
     26 /css/style.css
     15 /curriculum.pdf

 Data sent .............. 33.9 MB
```

## Challenges Faced

One challenge was understanding how to use AWK to extract information from different fields in a server log. Another challenge was counting unique visitors and sorting the most visited pages.

## What I Learnt

I learnt how to use Bash functions, loops, conditions, AWK, sorting commands, and pipes to analyse server log files. I also learnt how to handle errors and generate reports using `printf`.

## Author

**Joshua Kroos**
