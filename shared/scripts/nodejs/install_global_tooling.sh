#!/usr/bin/env bash

. ~/.bashrc;
function main {
  local method="$1"; method="${method:-install}";
  # trash-cli: safer rm, moves things to the trash rather than perm delete
  # prettier: code formatter
  # concurrently: run multiple simple commands or any kind of bash scripts at the same time
  #   useful for running multiple commands that hang a terminal at the same time with only needed 1 terminal window doing the work
  # gnomon: useful for timing an operation and deltas between prints in that operation
  local packages="trash-cli prettier concurrently gnomon sql-formatter-cli;";
  eval "npm $method --global $packages";
}

main $@
