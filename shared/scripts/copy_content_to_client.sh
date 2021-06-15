#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"
temp="$2"
tempShared="$3"
tempThis="$4"
flags="$5"
flags_as_int="$((2#$flags))"
vscode_flag_as_int="$((2#01))"

test -f "$tempThis/.ahk" && { cp -a "$tempThis/.ahk" "$HOME/"; }
cp -a "$tempShared/required/home/." "$HOME/"
cp -a "$tempShared/required/home_bin/." "$HOME/bin/"
cp -a "$tempShared/required/clipboard/." "$HOME/clipboard/"
cp -a "$tempShared/required/Tasks/." "$HOME/Tasks/"
[[ $(($vscode_flag_as_int & $flags_as_int)) == $vscode_flag_as_int ]] && {
  cp -a "$tempShared/required/vscodevim/." "$HOME/vscodevim/"
  cp -a "$tempShared/required/configs/vscode/." VSC_SETTINGS_DESTINATION_PLACEHOLDER
}

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
unset flags
unset flags_as_int
unset vscode_flag_as_int

