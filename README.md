# home-settings

## Purpose
For automating the setup of a developer machine
Currently only tested and in use on a Windows 10 machine.

## Tools
Makes use of:
- chocolatey
- vim
- git bash

## Installs
- chocolatey packages
- wsl ubuntu packages
- bash configs
- vim configs

## Install scripts

### Warning - The following script with override any files in the destination. It copys to locations such as the home directory!!
Use the copy.sh scripts found in ./setup/[windows|wsl_ubuntu|mac]/scripts/copy.sh to copy over vim, bash settings, tasks, and clipboard files. It will also clone a vim plugin manager, Vundle.

### Windows
To install chocolatey and clone this repo:
- ./setup/windows/scripts/bootstrap.ps1
To install windows software with chocolatey:
- ./setup/windows/scripts/install.ps1
To setup ssh keys for git:
- ./setup/windows/scripts/create_ssh_keys/1_admin.ps1
- ./setup/windows/scripts/create_ssh_keys/2_std_usr.ps1

## Bash tooling
### Notable bash functions/aliases
- whence <cmd> # gives the details of a bash command
- search_env_for(_fuzz)? "egrep|string|here" # searches the bash env for the given string (a fuzzy variant is available
- show_cmds_like "egrep|string|here" # sends impls of aliases and bash fns that match the regex to stdout (useful when
  piped to clip)
- grepn_files_freq # useful chained after find_in_files(_fuzz)?
- grepn_files_uniq # useful chained after find_in_files(_fuzz)?
- find_files(_fuzz)?
- find_files_rename(_preview)?
- find_in_files(_fuzz)?
- find_in_files_replace
- find_items
- tmuxns <optional_session_name> # Creates a tmux session based on the current path if the session name is not given
- tmuxks -t <session_name> # kill a tmux session
- tmuxas -t <session_name> # attach to a tmux session
- tmuxksvr # kills the tmux server
### Note on Notable bash functions/aliases
All of the find_ are wrappers around find to make certain common operations easy to perform.

Use whence to view the implementations of any of them to get an understanding of how they work

For more bash aliases and functions, use search_env_for(_fuzz)?, or look at ~/.bash_aliases and ~/.bash_functions

## TODO
- Windows: Upgrade wsl 1.0 to wsl 2.0 (package is managed with chocolatey)

