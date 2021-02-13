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


# Don't use ^D to exit
set -o ignoreeof

# Make bash append rather than overwrite the history on disk
shopt -s histappend
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
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


if [ -f ~/.bash_fns ]; then
        . ~/.bash_fns
fi

if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi

if [ -f ~/.bash_env_vars ]; then
        . ~/.bash_env_vars
fi

