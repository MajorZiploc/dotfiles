#!/usr/bin/env bash

function main {
  local pip_flags="$1"; pip_flags="${pip_flags:-""}";
  # rbql: rainbow query language; USE FLAG: --policy rfc
  # debugpy: debug adapter
  eval "pip install $pip_flags rbql debugpy";
}

main $@;
