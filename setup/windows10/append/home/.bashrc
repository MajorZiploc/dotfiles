if [ -d ~/AppData/Roaming/npm ]; then
  # Adds npm packages to path
  export PATH="$PATH:$(echo ~/AppData/Roaming/npm)"
fi