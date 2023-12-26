#!/bin/bash
# add.sh - Script for adding a new frame

# Get the directory of the current script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Parse the FRAMEWORKS from the var.json file in the current directory
FRAMEWORKS=$(jq -r '.FRAMEWORKS' "$DIR/var.json")


SCRIPTS_DIR="$FRAMEWORKS/scripts"

# Color variables
GREEN=$(tput setaf 2)
RED=$(tput sgr0)
RESET=$(tput sgr0)

# Function to add a new frame
add_new_frame() {
    read -p "Enter the name of the new frame: " new_frame_name

    # Check if the frame already exists
    if [ -d "$FRAMEWORKS/$new_frame_name" ]; then
        echo "${RED}Frame already exists.${RESET}"
        exit 1
    fi

    # Check if FRAMEWORKS directory exists
    if [ ! -d "$FRAMEWORKS" ]; then
        echo "${RED}FRAMEWORKS directory does not exist.${RESET}"
        exit 1
    fi

    # Create a new frame directory
    mkdir "$FRAMEWORKS/$new_frame_name"
    echo "${GREEN}Frame '$new_frame_name' added successfully.${RESET}"

    # cd into the new frame directory
    pushd "$FRAMEWORKS/$new_frame_name"

    # Check if npm is installed
    if ! command -v npm &> /dev/null
    then
        echo "${RED}npm could not be found.${RESET}"
        exit 1
    fi

    # Create a new package.json file
    npm init -y || { echo "${RED}Failed to initialize npm.${RESET}"; exit 1; }

    # the npm install command to install the required dependencies
    read -p "Enter command to install: " dependencies

    # Install the dependencies
    $dependencies
    # display the success message
    echo "${GREEN}Dependencies added successfully.${RESET}"
    # cd back to main directory
    popd
}

# Execute the add_new_frame function
add_new_frame