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
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:l[lsa]:l:h:history:show_path:hf'
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# allows for the use of ** for recursive globbing
shopt -s globstar
# Use case-insensitive filename globbing
shopt -s nocaseglob
# includes hidden items by default
shopt -s dotglob
# extends glob
shopt -s extglob

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

for file in `find "$HOME/.bashrc.d/" -maxdepth 1 -mindepth 1 -regextype egrep -iregex ".*\.bash" -type f`;
do
  . "$file";
done;

test -f ~/.bash_completion && . ~/.bash_completion

if [ -d ~/.local/bin ]; then
  export PATH="$PATH:$(echo ~/.local/bin)"
fi

# _ext bash files are for user specific edits to the bash environment
test -f ~/.bashrc_ext && . ~/.bashrc_ext

