#!/bin/bash

function append {
  local temp="$1"
  local tempShared="$2"
  local tempThis="$3"

  shopt -s globstar
  shopt -s dotglob
  
  appendHelper "$tempThis/append/home/*" "$tempShared/required/home"
  appendHelper "$tempThis/append/Tasks/*" "$tempShared/required/Tasks"
  appendHelper "$tempThis/append/clipboard/*" "$tempShared/required/clipboard"
  appendHelper "$tempThis/append/vscodevim/*" "$tempShared/required/vscodevim"
}

function appendHelper {
  dirGlob="$1"
  destDir="$2"
  for i in $dirGlob ; do
    [[ -f "$i" ]] && {
      local b=$(basename "$i")
      echo "cat \"$i\" >> \"$destDir/$b"
      echo "rm \"$i\""
      #cat "$i" >> "$destDir/$b"
      #rm "$i"
    }
  done;
}

append "$1" "$2" "$3"

