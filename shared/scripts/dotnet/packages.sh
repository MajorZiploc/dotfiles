#!/usr/bin/env bash

function main {
  local method="$1"; method="${method:-"install"}";
  if [[ "$method" == "install" ]]; then
    dotnet tool install -g fsautocomplete;
  else
    dotnet tool update -g fsautocomplete;
  fi
}

main $@;
