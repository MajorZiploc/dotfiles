# fc uses $FCEDIT, then $EDITOR, then vi
export FCEDIT='vim -u ~/.vim/rc-settings/terminal.vim'
# <c-x> <c-e> tries to use $VISUAL, then $EDITOR, and then emacs
export VISUAL='vim -u ~/.vim/rc-settings/terminal.vim'
# the fall back to fc and <c-x> <c-e> 
export EDITOR='vim'

# speed up rust build times
export RUSTC_WRAPPER="$HOME/.cargo/bin/sccache"

export NODE_ENV='development'
export NODE_TLS_REJECT_UNAUTHORIZED=0

export GIT_ORIGIN_BRANCH_CHOICES=(`echo "develop dev staging" | xargs`)
export GIT_DESTINATION_BRANCH_CHOICES=(`echo "main master " | xargs`)

export FIND_DEFAULT_IGNORE_DIRS=('bin' 'obj' '.git' '.svn' 'node_modules' '.ionide' '.venv' '__pycache__');

export FIND_GIT_EXTRA_IGNORE_DIRS=('node_modules' '.venv');
export FIND_GIT_DEFAULT_CHILD_GITIGNORE_SEARCH_DEPTH="0";

export FIND_DEFAULT_MAX_DEPTH=9;
