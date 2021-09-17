# fc uses $FCEDIT, then $EDITOR, then vi
export FCEDIT='/usr/bin/vim -u ~/_vimrcterm.vim'
# <c-x> <c-e> tries to use $VISUAL, then $EDITOR, and then emacs
export VISUAL='/usr/bin/vim -u ~/_vimrcterm.vim'

# the fall back to fc and <c-x> <c-e> 
export EDITOR='/usr/bin/vim'

export NODE_ENV='development'

# OG git bash prompt
# export PS1="\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$ "
# export PS1="\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$ "

# trimmed git bash prompt with success/fail colors
# export PS1="\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[35m\]\u@\h \`if [[ \$? = \"0\" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$ "

# export PROMPT_COMMAND="fate=$(if [[ \$? = \"0\" ]]; then echo \"\\[\\033[32m\\]\"; else echo \"\\[\\033[31m\\]\"; fi);git_branch=$(parse_git_branch)"

# trimmed git bash prompt with success/fail colors; refactored
# export PS1="\[\033[35m\]\u@\h ${fate}\w\[\033[36m\] (${git_branch})\[\033[0m\]\n$ "

# minimal prompt
export PS1="\[\033[34m\]@\h \`if [[ \$? = \"0\" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`\W\[\033[0m\]> "

