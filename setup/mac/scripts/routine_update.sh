#!/usr/bin/env zsh

scriptpath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

flags="$1";
[[ -z "$flags" ]] && { flags='0'; }
flags_as_int="$((2#$flags))";
full_install="$((2#1))";

function main {
  "$scriptpath/../../../shared/scripts/routine_update.sh";
  if [[ $(($full_install & $flags_as_int)) == $full_install ]]; then
    cp "$scriptpath/Brewfile" "$HOME/";
  else
    echo "$(cat "$scriptpath/Brewfile" | sed -E "s,(.*\# full_install)$,# \\1,g")" > "$HOME/Brewfile";
  fi
  ( cd "$HOME"; brew bundle; )
}

main

unset scriptpath;
