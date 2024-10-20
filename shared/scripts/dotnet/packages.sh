#!/usr/bin/env bash

function main {
  local method="$1"; method="${method:-"install"}";
  if [[ "$method" == "install" ]]; then
    dotnet tool install -g fsautocomplete;
    dotnet tool install -g ilspycmd;
  else
    dotnet tool update -g fsautocomplete;
    dotnet tool update -g ilspycmd;
  fi
}

main $@;
