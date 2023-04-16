#!/usr/bin/env zsh

scriptpath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

function main {
  "$script_path/nodejs/install_global_tooling.sh" "update";
  "$script_path/python/packages.sh" "-U";
  "$script_path/rust/packages.sh" "update";
}

main

unset scriptpath;
