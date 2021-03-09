#!/bin/bash

function append {
  local temp="$1"
  local tempShared="$2"
  local tempThis="$3"

  shopt -s globstar
  shopt -s dotglob
  
  local directory="$tempThis/append/home/*"
  for f in $directory ; do
    [[ -f "$f" ]] && {
      echo "$f";
      local b=$(basename "$f")
      echo "$b"
      # cat "$f" >> "$tempShared/required/home/$b"
      # rm "$f"
    }
  done;
}

append 1 2 "$1"

