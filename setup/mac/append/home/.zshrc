eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
export PATH="/opt/homebrew/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/zlib/lib/pkgconfig"
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
# For compilers to find openjdk@11 you may need to set:
# export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include"

# Rust
export PATH="$PATH:$HOME/.cargo/bin"
[[ -d $HOME/.cargo ]] && . $HOME/.cargo/env

