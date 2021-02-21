# Purpose
For automating the setup of a developer machine
Currently only tested and in use on a Windows 10 machine.

# Tools
Makes use of:
- chocolatey
- vim
- git bash

# Installs
- chocolatey packages
- wsl ubuntu packages
- bash configs
- vim configs

# Install scripts
To install chocolatey and clone this repo:
- ./setup/windows/scripts/bootstrap.ps1
To install windows software with chocolatey:
- ./setup/windows/scripts/install.ps1
To setup ssh keys for git:
- ./setup/windows/scripts/create_ssh_keys/1_admin.ps1
- ./setup/windows/scripts/create_ssh_keys/2_std_usr.ps1

Use the copy.sh scripts found in ./setup/[windows|wsl_ubuntu]/scripts/copy.sh to copy over vim and bash settings. It will also clone a vim plugin manager, Vundle.
