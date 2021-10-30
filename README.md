# home-settings

## Purpose
For automating the setup of a developer machine

## Tools

All:
- vim (text editor)
- nvim (text editor)
- bash (shell)
- zsh (shell)
- tmux (terminal multiplexier)
- pwsh (cross platform powershell)
- just (a command runner for Justfiles)
- asdf (a general programming language version manager)
- npm (node package manager)
- rg (ripgrep)
- dotnet (cross platform dotnet cli tooling)

Windows:
- chocolatey package manager

Ubuntu:
- apt package manager

WSL Ubuntu:
- apt package manager

Mac m1:
- homebrew

## Installs

All:
- bash configs
- vim configs
- zsh configs
- nvim configs
- vscode configs

Windows:
- chocolatey packages

Ubuntu:
- apt packages

## Install scripts

### Warning - The following script will override any files in the destination. It copies to locations such as the home directory!!
### It is highly recommended to back up your current settings!!!!
### The copy process makes use of sed substitutions that can affect the configs and the currently running copy scripts. See the substitutions for your os in ./setup/\<os\>/scripts/substitution.sh

Use the copy.sh scripts found in ./setup/[windows10|wsl\_ubuntu20.04|ubuntu20.04|macm1]/scripts/copy.sh "$flags" to copy over vscode keybindings and settings, vim, bash settings, tasks, and clipboard files. It will also clone a vim plugin manager, Vundle.

copy.sh : binary\_flags? -> unit

Paths with content that will be affected include but are not limited to:
- "$HOME/.bashrc"
- "$HOME/.bash\_profile"
- "$HOME/.bashrc.d/"
- "$HOME/.zsh\_completion.d/"
- "$HOME/.zshrc\_core"
- "$HOME/.zshrc"
- "$HOME/.zshrc.d/"
- "$HOME/.zshrc.pre-oh-my-zsh"
- "$HOME/.vim/bundle/"
- "$HOME/.vim/swap/"
- "$HOME/vimfiles/plugin-settings/"
- "$HOME/vimfiles/rc-settings/"
- "$HOME/.prettierrc"
- "$HOME/.prettierignore"
- "$HOME/clipboard/" when flags contain "10"
- "$HOME/bin/"
- "$HOME/Tasks/"
- "$HOME/vscodevim/" when flags contain "01"
- "$HOME/AppData/Roaming/Code/User/" (windows) else "$HOME/.config/Code/User/" when flags contain "01"

### Windows and Mac
To install chocolatey or home brew:
- ./setup/(windows10|macm1)/scripts/bootstrap.ps1
To install windows software with chocolatey:
- ./setup/(windows10|macm1)/scripts/install.ps1

### Ubuntu and Wsl Ubuntu
To install software with apt-get:
- ./setup/(wsl\_)?ubuntu20.04/scripts/install.ps1

## Bash tooling
### Notable bash functions/aliases
- whence <cmd> # gives the details of a bash command
- search\_env\_for(\_fuzz)? "egrep|string|here" # searches the bash env for the given string (a fuzzy variant is available
- show\_cmds\_like "egrep|string|here" # sends impls of aliases and bash fns that match the regex to stdout (useful when
  piped to clip)
- grepn\_files(\_freq|\_uniq)? # useful chained after find\_in\_files(\_fuzz)?
- [ag]?find\_files(\_fuzz)?
- [ag]?find\_files\_rename(\_preview)?
- [ag]?find\_in\_files(\_fuzz)?
- [ag]?find\_in\_files\_replace
- [ag]?find\_items
- tmuxcs <optional\_session\_name> # Creates a tmux session based on the current path if the session name is not given
- tmuxps <optional\_session\_name> # Creates a tmux session based the selected fzf/fzy folders specified by tmuxps\_get\_project\_dirs
- tmuxds <optional\_session\_name> # Creates a tmux session based the selected fzf/fzy folder from the users current path
- tmuxks -t <session\_name> # kill a tmux session
- tmuxas -t <session\_name> # attach to a tmux session
- tmuxksvr # kills the tmux server
- refresh\_settings(\_help|\_all|\_with\_flags)?
- show\_script\_path # useful when writing bash scripts to get the local of the script being written
- show\_cheat\_sheet # uses cht.sh to search for language or command functionality
- set\_\S+ # use search\_env\_for "set\_" to see all set functions available
- mssql\_exec # use to execute a sql command a database
- rest\_get # use to call a get rest request
- rest\_post # use to call a post rest request
- rest\_delete # use to call a delete rest request
- rest\_patch # use to call a patch rest request
- rest\_generic # use to call a generic rest request

### Special mentions on bash functions/aliases
All of the [ag]?find\_ are wrappers around find to make certain common operations easy to perform.

Use whence to view the implementations of any of them to get an understanding of how they work

For more bash aliases and functions, use search\_env\_for(\_fuzz)?, or look at ~/.bashrc.d/portable/\*

## Extending and Staying Up to date with these settings

### Staying up to date
If you want to stay up to date with this repo, then use the refresh\_settings bash function.

refresh\_settings will pull master on this repo (~/projects/home-settings) and call the copy script.

### Remember that the copy script will copy over any files that exist in the destination path that have the same name as files being copied from the source. See the Install Scripts section for more detail on this!!!

This means that if you edit the files in the destination and then call copy, it will overwrite them.

Example: you edit ~/.bashrc.d/portable/aliases.bash to add an alias, then call refresh\_settings. This will replace ~/.bashrc.d/portable/aliases.bash and you will lose your local edits

### Extending
The ~/.bashrc from this repo sources a file ~/.bashrc\_ext if it exists

The copy script does not have a .bashrc\_ext that it copies down, so the ~/.bashrc\_ext file is a safe place to add your own customizations of these bash settings.

The ~/.bashrc\_ext is sourced after all other bash files. So you can change the implementation of aliases and functions and shopt flags that you do not like with your own flavor.

Example: you do not like the fact that cdspell is turned on (shopt -s cdspell)

In ~/.bashrc\_ext, you can add the following line:

> shopt -u cdspell

This will turn that feature off!

This way you can have all the other great features you love from this repo, keep up to date with the repo, and make any changes that make these settings more you!

Use ~/.zshrc\_ext for zsh
Use ~/.vimrc\_ext for vim

## Development tools for contribution
- docker v20.10.7
- bash v5.0.17
- vim v8.1

## Developing in the docker container
To contribute without mudding up your own environment from the copy scripts. The copy scripts can be used within a docker container and all testing can happen there.

- Running docker container
> just start-container

- Attaching to the docker container (Run the rest of the development commands in the docker container)
> just connect-to-container

- The container is a based on a ubuntu image. So when you make changes to the shared content or ubuntu specific content and want to test them manually, then you need to run the copy down WITHIN the docker container
> just setup

### Unit tests in the docker container

- Run all the tests
> just run-tests

NOTE: you can also run a specific test file instead of all tests

View the Justfile for more commands and details on each command or use:
> just -l

