if [ -d ~/AppData/Roaming/npm ]; then
  # Adds npm packages to path
  export PATH="$PATH:$(echo ~/AppData/Roaming/npm)"
fi


if [ -d $HOME/.asdf ]; then
  . $HOME/.asdf/asdf.sh
  . $HOME/.asdf/completions/asdf.bash
fi

