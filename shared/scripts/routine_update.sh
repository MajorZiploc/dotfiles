#!/usr/bin/env zsh

scriptpath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

. "$HOME/.zshrc_core";

function main {
  "$scriptpath/update_vims.sh";
  omz update;
  "$scriptpath/update_packages.sh";
  "$scriptpath/update_git_repos.sh";
}

main

unset scriptpath;
