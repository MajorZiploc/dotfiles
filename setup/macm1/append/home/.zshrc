eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
export PATH="/opt/homebrew/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/zlib/lib/pkgconfig"

# Rust
export PATH="$PATH:/Users/manyu/.cargo/bin"
[[ -d $HOME/.cargo ]] && . $HOME/.cargo/env

export PATH="$HOME/.dotnet/tools:$PATH"

