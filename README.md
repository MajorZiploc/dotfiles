# dotfiles

## Purpose
For automating the setup of a developer machine

## Platforms these configs are used on:
- windows10
- windows11
- mac m1
- ubuntu 20.04
- wsl ubuntu 20.04
- android (REQUIRES MORE WORK: EXPERIMENTAL - Uses F-droid installed Termux - The Google Play Store has a depreciated version of Termux)

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

Mac:
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

Mac:
- brew packages

android: (FreeBSD)
- pkg and apt packages

## Install scripts

### NOTE:

### Windows and Mac
To install chocolatey or home brew:
- ./setup/(windows|mac)/scripts/bootstrap.(ps1|sh)

### Windows
To install windows software with chocolatey:
- ./setup/windows/scripts/install.ps1

### Ubuntu and Wsl Ubuntu and Mac and Android
To install software with apt-get:
- ./setup/((wsl_)?ubuntu|mac|android)/scripts/install.sh

### Vim setting shells
Make sure to set shells in the /usr/local/bin: (NOTE: for git bash, launch as admin and run the content of this file without the 'sudo')
- ./shared/scripts/vim_shell/set_shells.sh

### Nodejs (nvm)
Required for coc vim installs
- ./shared/scripts/nodejs/nvm_install_lts.sh

Misc tooling
- ./shared/scripts/nodejs/install_global_tooling.sh

### Rust (cargo)
install rust
- ./shared/scripts/rust/install.sh

Misc tooling; Adds color to fzf previews with bat!
- ./shared/scripts/rust/packages.sh

### dotnet
Misc tooling: install dotnet packages
- ./shared/scripts/dotnet/packages.sh

### Install oh my zsh
- ./shared/scripts/zsh/install_oh-my-zsh.sh

### Warning - The following script will override any files in the destination. It copies to locations such as the home directory!!
### It is highly recommended to back up your current settings!!!!
### The copy process makes use of sed substitutions that can affect the configs and the currently running copy scripts. See the substitutions for your os in ./setup/\<os\>/scripts/substitution.sh

NOTE: the copy script depends on the above install scripts being run prior, if you run the copy script before them, you will most likely experience problems

Use the copy.sh scripts found in ./setup/[windows|wsl_ubuntu|ubuntu|mac]/scripts/copy.sh "$flags" to copy over vscode keybindings and settings, vim, bash settings, tasks, and clipboard files. It will also clone a vim plugin manager, vim-plug.

copy.sh : binary_flags? -> unit

Paths with content that will be affected include but are not limited to:
- "$HOME/.bashrc"
- "$HOME/.bash_profile"
- "$HOME/.bashrc.d/"
- "$HOME/.zsh_completion.d/"
- "$HOME/.zshrc_core"
- "$HOME/.zshrc"
- "$HOME/.zshrc.d/"
- "$HOME/.vimrc"
- "$HOME/.ideavimrc"
- "$HOME/.config/nvim/"
- "$HOME/.zshrc.pre-oh-my-zsh"
- "$HOME/.vim/bundle/"
- "$HOME/.vim/swap/"
- "$HOME/.vim/coc-settings.json"
- "$HOME/.vim/plugin-settings/"
- "$HOME/.vim/rc-settings/"
- "$HOME/.prettierrc"
- "$HOME/.prettierignore"
- "$HOME/clipboard/" when flags contain "10"
- "$HOME/bin/"
- "$HOME/Tasks/"
- "$HOME/vscodevim/" when flags contain "01"
- "$HOME/AppData/Roaming/Code/User/" (windows) else "$HOME/.config/Code/User/" when flags contain "01"

### Install/Update various vims
This isnt perfect - for best results - open the vim you want to use and run the commands you see in this script
- ./shared/scripts/update_vims.sh

### Update global tooling
This will update various package manager packages for things like pip, npm, and cargo
- ./shared/scripts/update_packages.sh

## Troubleshooting

### on open of zsh: any of the following plugins complain about having problems: git, docker, docker-compose, zsh-autosuggestions, zsh-syntax-highlighting
- You need to rerun the oh my zsh install script and then rerun the copy down script.
- NOTE: make sure to pick the copy down script for your os in the following command
> ./shared/scripts/zsh/install_oh-my-zsh.sh && ./setup/(mac|wsl_ubuntu|ubuntu)/scripts/copy.sh

### on open of vim or nvim: coc issue where no intellisense is working
- Can be caused if you do not have nodejs, npm, and yarn installed (npm should work too). Install these tools then then do the following:
> cd ~/.vim/plugged/coc.nvim && yarn install

### on open of vim or nvim: ~/bin/bash or /usr/local/bin/zsh not found
- This can occur if you have yet to set symbolic links to your bash or zsh
> ./shared/scripts/vim_shell/set_shells.sh

### on open of vim or nvim: <some_vim_plugin> module not found problem
- You will need to open vim or nvim and install the plugins manually
> :PlugInstall

### on open of vim in git bash (windows specific issue): coc file not found.
- Some versions of coc do not work in vim v8.1.
- You can either remove the coc pluggin and pluggin settings or revert the plugin to a previous version

#### Remove the plugin
- delete the following lines from the ~/.vim/rc-settings/plugins.vim
> Plug 'neoclide/coc.nvim', {'branch': 'release'} " intellisense
> so ~/.vim/plugin-settings/coc.vim

#### Revert the plugin to a previous version
- This route will take more effort on your part
- You will need to go into the coc plugin repo:
> cd ~/.vim/plugged/coc.nvim
- Then delete the current node_modules folder
> rm -rf node_modules
- Then you will need to revert to a previous commit (I am unsure which commit you will need. Use git log to see commit hashs to try)
> git reset --hard <commit_hash>
- Then relaunch vim and coc should try to install various languages servers. you may need to use the following commands inside of vim:
> :PlugInstall
> :CocInstall
- You will know it is successful if vim pops up with a new window stating which language servers it is installing. Another way to know it was successful is if on open of vim, there is no error from coc
- Repeat the process until you find a commit that works. I know that there are releases in 2020 and 2021 that work (unless the rebase those releases away which I have seen happen)
- For further help. Google coc vim and look at their github docs

## Bash tooling
### Notable bash functions/aliases
- whence <cmd> # gives the details of a bash command
- search_env_for(_fuzz)? "grep -E|string|here" # searches the bash env for the given string (a fuzzy variant is available
- show_cmds_like "grep -E|string|here" # sends impls of aliases and bash fns that match the regex to stdout (useful when
  piped to clip)
- grepn_files(_freq|_uniq)? # useful chained after find_in_files(_fuzz)?
- [ag]?find_files(_fuzz)?
- [ag]?find_files_rename(_preview)?
- [ag]?find_in_files(_fuzz)?
- [ag]?find_in_files_replace
- [ag]?find_items
- tmuxcs <optional_session_name> # Creates a tmux session based on the current path if the session name is not given
- tmuxps <optional_session_name> # Creates a tmux session based the selected fzf/fzy folders specified by tmuxps_get_project_dirs
- tmuxds <optional_session_name> # Creates a tmux session based the selected fzf/fzy folder from the users current path
- tmuxks -t <session_name> # kill a tmux session
- tmuxas -t <session_name> # attach to a tmux session
- tmuxksvr # kills the tmux server
- refresh_settings(_help|_all|_with_flags)?
- show_script_path # useful when writing bash scripts to get the local of the script being written
- show_cheat_sheet # uses cht.sh to search for language or command functionality
- set_\S+ # use search_env_for "set_" to see all set functions available
- mssql_exec # use to execute a sql command a database
- rest_get # use to call a get rest request
- rest_post # use to call a post rest request
- rest_delete # use to call a delete rest request
- rest_patch # use to call a patch rest request
- rest_generic # use to call a generic rest request
- set_intersection # take the intersection of 2 sets
- set_are_disjoint # check if 2 sets are disjoint
- set_cardinality # get the number of elements in a set
- set_difference # take the difference of 2 sets (a - b)
- set_elem # check if item is an element of the set
- set_eq # check if 2 sets are equal
- set_is_subset # check if 1 set is a subset of another set
- set_maximum # get the max element of a set string wise
- set_maximum_num # get the max element of a set number wise
- set_minimum # get the min element of a set string wise
- set_minimum_num # get the min element of a set number wise
- set_symmetric_difference # get elements that occur in only one of the sets but not both
- set_union # get elements from either set or both

### Special mentions on bash functions/aliases
All of the [ag]?find_ are wrappers around find to make certain common operations easy to perform.

Use whence to view the implementations of any of them to get an understanding of how they work

For more bash aliases and functions, use search_env_for(_fuzz)?, or look at ~/.bashrc.d/portable/\*

### workplace_* bash functions
./shared/required/Tasks/workplace_bulk_ops.sh contains maybe great utilities for performing tasks on a batch of projects at once

If you wish to have them sourced in your bash or zsh environment, then place this line in your ~/.bashrc_ext or ~/.zshrc_ext file
> . ~/Tasks/workplace_bulk_ops.sh

### Even slimmer prompt by removing the whoami info from the beginning:
Put this in your ~/.zshrc_ext:
```
function set_prompt {
  PROMPT='%(?.%F{cyan}.%F{red}[$?])%c';
	local can_i_run_sudo=$(sudo -n uptime 2>&1 | grep "load" | wc -l);
	if [ ${can_i_run_sudo} -gt 0 ]; then
		PROMPT+='%{$fg_bold[red]%}!%{$reset_color%}';
	fi
  PROMPT+=' %F{magenta}${vcs_info_msg_0_}%F{cyan}> %F{reset}';
}
```

Put this in your ~/.bashrc_ext:
```
__bash_prompt() {
  local gitbranch='`\
    export BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null); \
    if [ "${BRANCH}" != "" ]; then \
    echo -n " \[\033[0;36m\](\[\033[1;31m\]${BRANCH}" \
    && echo -n "\[\033[0;36m\])"; \
  fi`'
  local removecolor='\[\033[0m\]'
  PS1="\`if [[ \$? = \"0\" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]\[\$?\]"; fi\`\W${gitbranch}${removecolor}> "
  unset -f __bash_prompt
}
__bash_prompt
```


## Extending and Staying Up to date with these settings

### Staying up to date
If you want to stay up to date with this repo, then use the refresh_settings bash function.

refresh_settings will pull master on this repo (~/projects/dotfiles) and call the copy script.

### Remember that the copy script will copy over any files that exist in the destination path that have the same name as files being copied from the source. See the Install Scripts section for more detail on this!!!

This means that if you edit the files in the destination and then call copy, it will overwrite them.

Example: you edit ~/.bashrc.d/portable/aliases.bash to add an alias, then call refresh_settings. This will replace ~/.bashrc.d/portable/aliases.bash and you will lose your local edits

### Extending
The ~/.bashrc from this repo sources a file ~/.bashrc_ext if it exists

The copy script does not have a .bashrc_ext that it copies down, so the ~/.bashrc_ext file is a safe place to add your own customizations of these bash settings.

The ~/.bashrc_ext is sourced after all other bash files (minus OS specific append flow ~/.bashrc content). So you can change the implementation of aliases and functions and shopt flags that you do not like with your own flavor.

Example: you do not like the fact that cdspell is turned on (shopt -s cdspell)

In ~/.bashrc_ext, you can add the following line:

> shopt -u cdspell

This will turn that feature off!

This way you can have all the other great features you love from this repo, keep up to date with the repo, and make any changes that make these settings more you!

Use ~/.zshrc_ext for zsh

Use ~/.vimrc_ext for vim

## Development tools for contribution
- docker v20.10.7
- bash v5.0.17 or zsh
- vim v8.1 or nvim

## Copy env file (make changes if needed)
> cp .example.env .env

## Developing in the docker container
To contribute without mudding up your own environment from the copy scripts. The copy scripts can be used within a docker container and all testing can happen there.

- Source just.bash from root of project
> . ./just.bash;

- Running docker container
> just_docker_container_start

- Attaching to the docker container (Run the rest of the development commands in the docker container)
> just_docker_container_connect

- The container is a based on a ubuntu image. So when you make changes to the shared content or ubuntu specific content and want to test them manually, then you need to run the copy down WITHIN the docker container
> just_setup

### Unit tests in the docker container

- Run all the tests
> just_run_tests

NOTE: you can also run a specific test file instead of all tests

View the Justfile for more commands and details on each command or use (at the root of this project):
> cat just.bash


## TODO:

- Cleanup ubuntu-slim-container
  - was rushed and has alot of things around that it does not need
