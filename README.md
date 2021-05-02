# home-settings

## Purpose
For automating the setup of a developer machine

## Tools
Makes use of:
- chocolatey package manager
- vim
- bash
- apt package manager
- tmux
- pwsh (cross platform powershell)

## Installs
- chocolatey packages
- apt packages
- bash configs
- vim configs
- vscode configs

## Install scripts - ALWAYS read scripts you are going to execute!!!!

### Warning - The following script will override any files in the destination. It copies to locations such as the home directory!!
### It is highly recommended to back up your current settings!!!!
### The copy process makes use of sed substitutions that can affect the configs and the currently running copy scripts. See the substitutions for your os in ./setup/\<os\>/scripts/substitution.sh

Use the copy.sh scripts found in ./setup/[windows|wsl_ubuntu|mac]/scripts/copy.sh to copy over vscode keybindings and settings, vim, bash settings, tasks, and clipboard files. It will also clone a vim plugin manager, Vundle.

Paths with content that will be affected include but are not limited to:
- "$HOME/.vim/bundle"
- "$HOME/.vim/swap"
- "$HOME/vimfiles/plugin-settings"
- "$HOME/clipboard"
- "$HOME/bin"
- "$HOME/Tasks"
- "$HOME/vscodevim"
- "$HOME/AppData/Roaming/Code/User/"

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
- grepn_files(_freq|_uniq)? # useful chained after find_in_files(_fuzz)?
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

## Extending and Staying Up to date with these settings

### Staying up to date (Important notes for extending aswell)
If you want to stay up to date with this repo, then use the refresh_settings bash function.

refresh_settings will pull master on this repo (/c/projects/home-settings for windows else ~/projects/home-settings) and call the copy script.

### Remember that the copy script will copy over any files that exist in the destination path that have the same name as files being copied from the source. See the Install Scripts section for more detail on this!!!

This means that if you edit the files in the destination and then call copy, it will overwrite them.

Example: you edit ~/.bash_aliases to add an alias, then call refresh_settings. This will replace ~/.bash_aliases and you will lose your local edits

### Extending
The ~/.bashrc from this repo sources a file ~/.bash_ext if it exists

The copy script does not have a .bash_ext that it copies down, so the ~/.bash_ext file is a safe place to add your own customizations of these bash settings.

The ~/.bash_ext is sourced after all other bash files. So you can change the implementation of aliases and functions and shopt flags that you do not like with your own flavor.

Example: you do not like the fact that cdspell is turned on (shopt -s cdspell)

In ~/.bash_ext, you can add the following line:

> shopt -u cdspell

This will turn that feature off!

This way you can have all the other great features you love from this repo, keep up to date with the repo, and make any changes that make these settings more you!

## TODO
- Windows: Upgrade wsl 1.0 to wsl 2.0 (package is managed with chocolatey)

