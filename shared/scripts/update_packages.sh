#!/usr/bin/env zsh

scriptpath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

function main {
  "$scriptpath/nodejs/install_global_tooling.sh" "update";
  "$scriptpath/python/packages.sh" "-U";
  "$scriptpath/rust/packages.sh" "update";
}

main

unset scriptpath;
