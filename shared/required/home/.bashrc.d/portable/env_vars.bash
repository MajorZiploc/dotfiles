# fc uses $FCEDIT, then $EDITOR, then vi
export FCEDIT='vim -u ~/.vim/rc-settings/terminal.vim'
# <c-x> <c-e> tries to use $VISUAL, then $EDITOR, and then emacs
export VISUAL='vim -u ~/.vim/rc-settings/terminal.vim'
# the fall back to fc and <c-x> <c-e> 
export EDITOR='vim'

# speed up rust build times
export RUSTC_WRAPPER="$HOME/.cargo/bin/sccache"

export NODE_ENV='development'

export NODE_TLS_REJECT_UNAUTHORIZED=1
# IF SSL issues like local ssl cert issues
# export NODE_TLS_REJECT_UNAUTHORIZED=0
# if its a per project thing. better to just do this rather than the above for the whole env:
# NODE_TLS_REJECT_UNAUTHORIZED=0 npm install
# or potentially this:
# NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt npm install
# or potentially this in .npmrc file
# use-system-ca=true
# or potentially this on cli
# npm install --use-system-ca
# or potentially this in .npmrc file
# use-openssl-ca=true
# or potentially this on cli
# npm install --use-openssl-ca

export GIT_ORIGIN_BRANCH_CHOICES=(`echo "develop dev staging" | xargs`)
export GIT_DESTINATION_BRANCH_CHOICES=(`echo "main master " | xargs`)

export FIND_DEFAULT_IGNORE_DIRS=('bin' 'obj' '.git' '.svn' 'node_modules' '.ionide' '.venv' '__pycache__');

export FIND_GIT_EXTRA_IGNORE_DIRS=('node_modules' '.venv');

export FIND_DEFAULT_MAX_DEPTH=99;
export FIND_GIT_DEFAULT_CHILD_GITIGNORE_SEARCH_DEPTH=3;
export FIND_SHOULD_SHOW_COMMAND="false";

export GIT_COLOR_WORDS='[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+';
