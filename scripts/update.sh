#!/bin/bash

# Function to display spinner
spinner() {
  local pid=$1
  local delay=0.2
  local spinstr='|/-\'
  while ps -p $pid > /dev/null; do
    local temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    local spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
  printf "    \b\b\b\b"
}

# Get the directory of the current script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Parse the FRAMEWORKS from the var.json file in the current directory
FRAMEWORKS=$(jq -r '.FRAMEWORKS' "$DIR/var.json")

# Loop over each framework in the directory
for FRAMEWORK in "$FRAMEWORKS"/*; do
    # if the dir equals scripts, skip
    if [ "$FRAMEWORK" = "$FRAMEWORKS/scripts" ]; then
        continue
    fi

  # Check if it's a directory
  if [ -d "$FRAMEWORK" ]; then
    tput setaf 2
    echo -n "Updating $FRAMEWORK..."
    tput sgr0

    # Navigate into the framework directory
    cd "$FRAMEWORK"

    # Check if the directory is included package.json
    if [ ! -f "package.json" ]; then
        echo "Not a noderojectjs p. Skipping..."
        continue
    else
        # Run npm install in the background
        npm install > /dev/null 2>&1 &
        npm update > /dev/null 2>&1 &
        # Call spinner function with the background process ID
        spinner $!
        tput setaf 2
        echo " Updated"
        tput sgr0  
    fi

    # Navigate back to the original directory without printing anything
    cd - > /dev/null 2>&1
  fi
done

tput setaf 2
echo "All frameworks updated."
tput sgr0
