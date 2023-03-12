# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Don't use ^D to exit
set -o ignoreeof

# Make bash append rather than overwrite the history on disk
shopt -s histappend
# reedit history ! cmds that fail quicker
shopt -s histreedit
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# Puts a time stamp on the history entries
export HISTTIMEFORMAT="%Y-%m-%d %T "
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
# includes hidden items by default
shopt -s dotglob
# extends glob
shopt -s extglob

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

shopt -s expand_aliases

for file in `find "$HOME/.bashrc.d/" -regextype egrep -iregex ".*\.bash" -type f`; do
  . "$file" >/dev/null 2>&1;
done;

for file in `find "$HOME/.bash_completion.d/" -maxdepth 1 -mindepth 1 -regextype egrep -iregex ".*\.bash" -type f`; do
  . "$file" >/dev/null 2>&1;
done;

export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/local/bin:$PATH"

# Codespaces bash prompt theme based off of a docker container bash prompt
__bash_prompt() {
  local gitbranch='`\
    export BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null); \
    if [ "${BRANCH}" != "" ]; then \
    echo -n " \[\033[0;36m\](\[\033[1;31m\]${BRANCH}" \
    && echo -n "\[\033[0;36m\])"; \
  fi`'
  local lightblue='\[\033[1;34m\]'
  local darkblue='\[\033[0;34m\]'
  local removecolor='\[\033[0m\]'
  PS1="${darkblue}@${lightblue}\h \`if [[ \$? = \"0\" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]\[\$?\]"; fi\`\W${gitbranch}${removecolor}> "
  unset -f __bash_prompt
}
__bash_prompt
export PROMPT_DIRTRIM=4

test -d ~/.dotnet/tools && export PATH="$HOME/.dotnet/tools:$PATH"
# _ext bash files are for user specific edits to the bash environment
test -e ~/.bashrc_ext && . ~/.bashrc_ext
