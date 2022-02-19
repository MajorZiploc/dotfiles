if [ -d ~/AppData/Roaming/npm ]; then
  # Adds npm packages to path
  export PATH="$PATH:$(echo ~/AppData/Roaming/npm)"
fi

if [ -d $HOME/.asdf ]; then
  . $HOME/.asdf/asdf.sh
  . $HOME/.asdf/completions/asdf.bash
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH="$HOME/.dotnet/tools:$PATH"

