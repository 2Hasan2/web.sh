# Frame Management Scripts

This repository contains scripts for managing frames in a specified directory.

## Project Overview

This project provides a bash script, `app.sh`, designed to clone different frameworks from a specified directory (`FRAMEWORKS`) and create a new directory. The script is intended to simplify the process of setting up and managing project structures based on predefined frameworks.

## setup
1. how to run it from any where :
```sh
nano ~/.bashrc
```
if you have `vsc`
```sh
code ~/.bashrc
```

2. add alias for it
```sh
alias web='PATH_TO_DIR/FrameWork/app.sh
```
3. save and run:
```sh
source ~/.bashrc
```

## usage

- <frame> : 
- <dir> :(Optional) The directory where the new project will be created. If not provided, the script will use the current working directory.

```sh
web <frame> <dir>
```

## Available Commands

- `-h` or `--help`: Display usage information.
- `-l` or `--list`: List available frameworks.
- `-u` or `--update`: Update frameworks.
- `-a` or `--add`: Add a new framework.
- `-d` or `--delete`: Remove an existing framework.
- `-r` or `--run`: Run the application from the specified directory.

## Note
Ensure that the necessary permissions are set to execute all scripts
- use: `chmod +x SCRIPT_NAME.sh`