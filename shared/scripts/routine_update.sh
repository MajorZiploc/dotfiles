#!/usr/bin/env zsh

scriptpath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

. "$HOME/.zshrc_core";

function main {
  "$scriptpath/update_vims.sh";
  "$scriptpath/update_packages.sh";
  "$scriptpath/update_git_repos.sh";
  omz update;
}

main

unset scriptpath;
