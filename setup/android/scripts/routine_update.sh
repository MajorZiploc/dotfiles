#!/usr/bin/env zsh

scriptpath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

function main {
  "$scriptpath/../../../shared/scripts/routine_update.sh";
  pkg upgrade -y;
  pkg update -y;
}

main

unset scriptpath;
