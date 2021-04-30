#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"
temp="$2"
tempShared="$3"
tempThis="$4"

test -f "$tempThis/.ahk" && { cp -a "$tempThis/.ahk" "$HOME/"; }
cp -a "$tempShared/required/home/." "$HOME/"
cp -a "$tempShared/required/home_bin/." "$HOME/bin/"
cp -a "$tempShared/required/clipboard/." "$HOME/clipboard/"
cp -a "$tempShared/required/Tasks/." "$HOME/Tasks/"
cp -a "$tempShared/required/vscodevim/." "$HOME/vscodevim/"
cp -a "$tempShared/required/AppData/Roaming/Code/User/." "$HOME/AppData/Roaming/Code/User/"

# download vundle if it does not exist
vunDir="$HOME/.vim/bundle/Vundle.vim"
[[ -d $vunDir ]] || {
  cd "$HOME/.vim/bundle"
  git clone https://github.com/VundleVim/Vundle.vim.git "$vunDir"
  cd "$HOME"
}

unset setupRoot
unset tempShared
unset tempThis
unset temp

