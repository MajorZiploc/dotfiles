eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
export PATH="/opt/homebrew/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/zlib/lib/pkgconfig"
# for v11
# export MY_JAVA_VERSION="@11";
# for v17
export MY_JAVA_VERSION="@17";
# for latest
# export MY_JAVA_VERSION="";
export PATH="/opt/homebrew/opt/openjdk${MY_JAVA_VERSION}/bin:$PATH"
# For compilers to find openjdk you may need to set:
# export CPPFLAGS="-I/opt/homebrew/opt/openjdk${MY_JAVA_VERSION}/include"
export JAVA_HOME="/opt/homebrew/opt/openjdk${MY_JAVA_VERSION}";
export JRE_HOME="/opt/homebrew/opt/openjdk${MY_JAVA_VERSION}";

# Rust
export PATH="$PATH:$HOME/.cargo/bin"
[[ -d $HOME/.cargo ]] && . $HOME/.cargo/env

# golang
# [[ -e $HOME/.gvm/scripts/gvm ]] && . ~/.gvm/scripts/gvm;

# ruby - the default location if not using rvm
# export GEM_HOME="$HOME/.gem";

# ruby - rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# adds python version manager to path
export PATH="$(pyenv root)/shims:$PATH";
