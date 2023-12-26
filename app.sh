#!/bin/bash
# Usage: ./app.sh <frame> <dir>
# Description: Clone a frame from FRAMEWORKS and create a new directory.

FRAMEWORKS="/home/$(whoami)/FrameWorks"
SCRIPTS_DIR="$FRAMEWORKS/scripts"

FRAME=$1
DIR=${2:-$(pwd)}

# Color variables
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

display_help() {
    echo "Usage: ./app.sh <frame> <dir>"
    echo "Description: Clone the frame from FRAMEWORKS and create a new directory in the current directory."
    exit 0
}

list_frames() {
    echo "${GREEN}Available frames:${RESET}"
    # List all the directories in FRAMEWORKS exipt the scripts directory and files
    ls -l "$FRAMEWORKS" | grep '^d' | awk '{print $9}' | grep -v scripts
    exit 0
}

update_frames() {
    echo "${GREEN}Updating frames...${RESET}"
    "$SCRIPTS_DIR/update.sh"
    exit 0
}

add_frame() {
    echo "${GREEN}Adding frame...${RESET}"
    "$SCRIPTS_DIR/add.sh"
    exit 0
}

remove_frame() {
    echo "${GREEN}Removing frame...${RESET}"
    "$SCRIPTS_DIR/remove.sh"
    exit 0
}

check_frame_exists() {
    if [ ! -d "$FRAMEWORKS/$FRAME" ]; then
        echo "${RED}Frame does not exist.${RESET}"
        exit 1
    fi
}

check_directory_exists() {
    if [ ! -d "$FRAMEWORKS" ]; then
        echo "${RED}FRAMEWORKS directory does not exist.${RESET}"
        exit 1
    fi
}

create_directory() {
    if [ ! -d "$DIR" ]; then
        echo "${RED}Directory does not exist.${RESET}"
        read -p "Do you want to create it? [y/n] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            mkdir "$DIR"
        else
            exit 1
        fi
    fi
}

check_directory_empty() {
    if [ "$(ls -A "$DIR")" ]; then
        echo "${RED}Directory is not empty.${RESET}"
        exit 1
    fi
}

clone_frame() {
    echo "Cloning frame $FRAME to $DIR"
    cp -r "$FRAMEWORKS/$FRAME"/* "$DIR"
    echo "Done"
}

run_frame() {

    echo "Running app from ${GREEN}$DIR${RESET}"
    "$SCRIPTS_DIR/run.sh" "$DIR"
}

# Check for empty frame
if [ -z "$FRAME" ]; then
    # run it with -l flag
    list_frames
    # make the user choose a frame by arrow keys
fi


case "$FRAME" in
    -h|--help) display_help ;;
    -l|--list) list_frames ;;
    -u|--update) update_frames ;;
    -a|--add) add_frame ;;
    -d|--delete) remove_frame ;;
    -r|--run) run_frame;;
    *) 
        check_frame_exists
        check_directory_exists
        create_directory
        check_directory_empty
        clone_frame
        ;;
esac