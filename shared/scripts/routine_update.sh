#!/usr/bin/env bash

scriptpath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

function main {
  omz update;
  "$scriptpath/update_vims.sh";
  "$scriptpath/update_packages.sh";
}

main

unset scriptpath;
