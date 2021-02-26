################################## Construct PATH variable ##################################

#winpath=$(echo $MSYS2_WINPATH | tr ";" "\n" | sed -e 's/\\/\\\\/g' | xargs -I {} cygpath -u {})
#unixpath=''

# Set delimiter to new line
#IFS=$'\n'

#for pth in $winpath; do unixpath+=$(echo $pth)":"; done

#export PATH=$(echo $PATH:$unixpath | sed -e 's/:$//g')
#unset IFS
#unset unixpath
#unset winpath

################################# Constructed PATH variable #################################

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


if [ -f ~/.bash_functions ]; then
        . ~/.bash_functions
fi

if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi

if [ -f ~/.bash_env_vars ]; then
        . ~/.bash_env_vars
fi

if [ -d ~/AppData/Roaming/npm ]; then
  # Adds npm packages to path
  export PATH="$PATH:$(echo ~/AppData/Roaming/npm)"
fi

