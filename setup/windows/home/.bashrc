# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Don't use ^D to exit
set -o ignoreeof

# Make bash append rather than overwrite the history on disk
shopt -s histappend
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:l[lsa]:l:h:history:show_path'
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# allows for the use of ** for recursive globbing
shopt -s globstar
# Use case-insensitive filename globbing
shopt -s nocaseglob

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell


test -f ~/.bash_functions && . ~/.bash_functions
test -f ~/.bash_aliases && . ~/.bash_aliases
test -f ~/.bash_env_vars && . ~/.bash_env_vars

if [ -d ~/AppData/Roaming/npm ]; then
  # Adds npm packages to path
  export PATH="$PATH:$(echo ~/AppData/Roaming/npm)"
fi

# _ext bash files are for user specific edits to the bash environment
test -f ~/.bashrc_ext && . ~/.bashrc_ext

