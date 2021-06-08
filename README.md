# home-settings

## Purpose
For automating the setup of a developer machine

## Tools
Makes use of:
All:
- vim
- bash
- tmux
- pwsh (cross platform powershell)

Windows:
- chocolatey package manager

Ubuntu:
- apt package manager

WSL Ubuntu:
- apt package manager



## Installs
All:
- bash configs
- vim configs
- vscode configs

Windows:
- chocolatey packages

Ubuntu:
- apt packages


## Install scripts - ALWAYS read scripts you are going to execute!!!!

### Warning - The following script will override any files in the destination. It copies to locations such as the home directory!!
### It is highly recommended to back up your current settings!!!!
### The copy process makes use of sed substitutions that can affect the configs and the currently running copy scripts. See the substitutions for your os in ./setup/\<os\>/scripts/substitution.sh

Use the copy.sh scripts found in ./setup/[windows10|wsl1\_ubuntu20.04|ubuntu20.04|mac]/scripts/copy.sh to copy over vscode keybindings and settings, vim, bash settings, tasks, and clipboard files. It will also clone a vim plugin manager, Vundle.

Paths with content that will be affected include but are not limited to:
- "$HOME/.vim/bundle"
- "$HOME/.vim/swap"
- "$HOME/vimfiles/plugin-settings"
- "$HOME/clipboard"
- "$HOME/bin"
- "$HOME/Tasks"
- "$HOME/vscodevim"
- "$HOME/AppData/Roaming/Code/User/" (windows) else "$HOME/.config/Code/User/"

### Windows
To install chocolatey and clone this repo:
- ./setup/windows/scripts/bootstrap.ps1
To install windows software with chocolatey:
- ./setup/windows/scripts/install.ps1
To setup ssh keys for git:
- ./setup/windows/scripts/create\_ssh\_keys/1\_admin.ps1
- ./setup/windows/scripts/create\_ssh\_keys/2\_std\_usr.ps1

## Bash tooling
### Notable bash functions/aliases
- whence <cmd> # gives the details of a bash command
- search\_env\_for(\_fuzz)? "egrep|string|here" # searches the bash env for the given string (a fuzzy variant is available
- show\_cmds\_like "egrep|string|here" # sends impls of aliases and bash fns that match the regex to stdout (useful when
  piped to clip)
- grepn\_files(\_freq|\_uniq)? # useful chained after find\_in\_files(\_fuzz)?
- find\_files(\_fuzz)?
- find\_files\_rename(\_preview)?
- find\_in\_files(\_fuzz)?
- find\_in\_files\_replace
- find\_items
- tmuxcs <optional\_session\_name> # Creates a tmux session based on the current path if the session name is not given
- tmuxks -t <session\_name> # kill a tmux session
- tmuxas -t <session\_name> # attach to a tmux session
- tmuxksvr # kills the tmux server
### Note on Notable bash functions/aliases
All of the find\_ are wrappers around find to make certain common operations easy to perform.

Use whence to view the implementations of any of them to get an understanding of how they work

For more bash aliases and functions, use search\_env\_for(\_fuzz)?, or look at ~/.bash\_aliases and ~/.bash\_functions

## Extending and Staying Up to date with these settings

### Staying up to date (Important notes for extending aswell)
If you want to stay up to date with this repo, then use the refresh\_settings bash function.

refresh\_settings will pull master on this repo (~/projects/home-settings) and call the copy script.

### Remember that the copy script will copy over any files that exist in the destination path that have the same name as files being copied from the source. See the Install Scripts section for more detail on this!!!

This means that if you edit the files in the destination and then call copy, it will overwrite them.

Example: you edit ~/.bash\_aliases to add an alias, then call refresh\_settings. This will replace ~/.bash\_aliases and you will lose your local edits

### Extending
The ~/.bashrc from this repo sources a file ~/.bash\_ext if it exists

The copy script does not have a .bash\_ext that it copies down, so the ~/.bash\_ext file is a safe place to add your own customizations of these bash settings.

The ~/.bash\_ext is sourced after all other bash files. So you can change the implementation of aliases and functions and shopt flags that you do not like with your own flavor.

Example: you do not like the fact that cdspell is turned on (shopt -s cdspell)

In ~/.bash\_ext, you can add the following line:

> shopt -u cdspell

This will turn that feature off!

This way you can have all the other great features you love from this repo, keep up to date with the repo, and make any changes that make these settings more you!

## TODO
- Windows: Upgrade wsl 1.0 to wsl 2.0 (package is managed with chocolatey)

