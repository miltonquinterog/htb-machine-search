# HTB Machine Search

A Bash script that allows you to quickly search solved Hack The Box machines from a local dataset.

## First Run

The script will automatically download the required `bundle.js` file if it is not present.

## Features

* Search machines by name
* Search by operating system
* Search by difficulty
* Combine operating system and difficulty filters.
* Fast local searches
* Lightweight and easy to customize
* Display the YouTube walkthrough for a machine (when available).
* Automatically download and update `bundle.js`.

## Requirements

Before using the script, download the latest `bundle.js` file and place it in the project directory.
* Linux
* Bash
* curl
* grep
* awk

## Usage

Features
Search Hack The Box machines by name.
Filter by operating system.
Filter by difficulty.
Automatically downloads and updates the required bundle.js file.
Lightweight Bash implementation.

Clone the repository:

```bash
git clone https://github.com/miltonquinterog/htb-machine-search.git
cd htb-machine-search
chmod +x htb-machine-search.sh
./htb-machine-search.sh
```

## Purpose

This project was created to practice Bash scripting and Linux command-line automation for cybersecurity learning.

## Disclaimer

This project is intended for educational purposes only and does not interact directly with Hack The Box services.
