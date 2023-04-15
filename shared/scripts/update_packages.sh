#!/usr/bin/env zsh

function main {
  local script_path; script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";
  "$script_path/nodejs/install_global_tooling.sh" "update";
  "$script_path/python/packages.sh" "-U";
  "$script_path/rust/packages.sh" "update";
}

main
