#!/bin/bash
# remove.sh - Script for removing a frame
# Get the directory of the current script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Parse the FRAMEWORKS from the var.json file in the current directory
FRAMEWORKS=$(jq -r '.FRAMEWORKS' "$DIR/var.json")

# Color variables
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

# Function to remove a frame
remove_frame() {
    read -p "Enter the name of the frame to remove: " frame_name

    # Check if the frame exists
    if [ ! -d "$FRAMEWORKS/$frame_name" ]; then
        echo "${RED}Frame does not exist.${RESET}"
        exit 1
    else
        # Check if the frame is empty
        if [ "$(ls -A "$FRAMEWORKS/$frame_name")" ]; then
            echo "${RED}Frame is not empty.${RESET}"
            # ask for confirmation
            read -p "Are you sure you want to remove the frame? [y/N]: " confirm

            # check if the user wants to continue
            if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
                echo "${RED}Aborted.${RESET}"
                exit 1
            else
                # remove the frame
                rm -rf "$FRAMEWORKS/$frame_name"
                echo "${GREEN}Frame '$frame_name' removed successfully.${RESET}"
            fi
        else
            # remove the frame
            rm -rf "$FRAMEWORKS/$frame_name"
            echo "${GREEN}Frame '$frame_name' removed successfully.${RESET}"
        fi
    fi
}

# Execute the remove_frame function
remove_frame