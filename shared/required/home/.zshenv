# THIS IS REQUIRED TO ALLOW FOR BASH ALIASES TO RUN INSIDE VIM
# NOTABLE SIDEFFECT: THIS IS SOURCED FOR ALL ZSH SCRIPTS. BE CAREFUL WHEN WRITING ZSH SCRIPTS
# This is also always sourced on zsh interactive regardless of it being sourced from ~/.zshrc

setopt aliases
. ~/.bashrc.d/portable/aliases.bash

