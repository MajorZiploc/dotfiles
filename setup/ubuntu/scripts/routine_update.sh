#!/usr/bin/env zsh

scriptpath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

function main {
  "$scriptpath/../../../shared/scripts/routine_update.sh";
  sudo apt-get update -y;
  sudo apt-get upgrade -y;
}

main

unset scriptpath;
