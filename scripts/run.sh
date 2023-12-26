#!/bin/bash
# Check if user entered a path to run the script
if [ -n "$1" ]; then
    cd "$1"
fi

# Check if run.config file exists
if [ -f "run.config" ]; then
    config=$(cat run.config)
    eval "$config"
else
    echo "Error: run.config file not found in the current directory."
fi
