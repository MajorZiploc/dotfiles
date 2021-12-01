# fc uses $FCEDIT, then $EDITOR, then vi
export FCEDIT='vim -u ~/vimfiles/rc-settings/terminal.vim'
# <c-x> <c-e> tries to use $VISUAL, then $EDITOR, and then emacs
export VISUAL='vim -u ~/vimfiles/rc-settings/terminal.vim'

# the fall back to fc and <c-x> <c-e> 
export EDITOR='vim'

export NODE_ENV='development'

export NODE_TLS_REJECT_UNAUTHORIZED=0

