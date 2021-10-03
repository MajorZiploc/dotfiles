# fc uses $FCEDIT, then $EDITOR, then vi
export FCEDIT='/usr/bin/vim -u ~/vimfiles/rc-settings/terminal.vim'
# <c-x> <c-e> tries to use $VISUAL, then $EDITOR, and then emacs
export VISUAL='/usr/bin/vim -u ~/vimfiles/rc-settings/terminal.vim'

# the fall back to fc and <c-x> <c-e> 
export EDITOR='/usr/bin/vim'

export NODE_ENV='development'

