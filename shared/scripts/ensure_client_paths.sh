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
clipboard_flag_as_int="$((2#10))"

mkdir -p "$HOME/.vim/bundle"
mkdir -p "$HOME/.vim/swap"
mkdir -p "$HOME/vimfiles/plugin-settings"
[[ $(($clipboard_flag_as_int & $flags_as_int)) == $clipboard_flag_as_int ]] && {
  mkdir -p "$HOME/clipboard"
}
mkdir -p "$HOME/bin"
mkdir -p "$HOME/Tasks"
[[ $(($vscode_flag_as_int & $flags_as_int)) == $vscode_flag_as_int ]] && {
  mkdir -p "$HOME/vscodevim"
  mkdir -p VSC_SETTINGS_DESTINATION_PLACEHOLDER
}

unset setupRoot
unset tempShared
unset tempThis
unset temp
unset flags
unset flags_as_int
unset vscode_flag_as_int
unset clipboard_flag_as_int

