#!/usr/bin/env zsh

scriptpath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

function main {
  "$scriptpath/../../../shared/scripts/routine_update.sh";
  cp "$scriptpath/Brewfile" "$HOME/Brewfile";
  ( cd "$HOME"; brew bundle; )
  sudo port -v selfupdate;
}

main

unset scriptpath;
