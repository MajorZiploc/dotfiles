#!/usr/bin/env bash

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
tasks_flag_as_int="$((2#100))"

test -f "$tempThis/.ahk" && { cp -a "$tempThis/.ahk" "$HOME/"; }
cp -a "$tempShared/required/home/." "$HOME/"
cp -a "$tempShared/required/home_bin/." "$HOME/bin/"
[[ $(($clipboard_flag_as_int & $flags_as_int)) == $clipboard_flag_as_int ]] && {
  cp -a "$tempShared/required/clipboard/." "$HOME/clipboard/"
}
[[ $(($tasks_flag_as_int & $flags_as_int)) == $tasks_flag_as_int ]] && {
  cp -a "$tempShared/required/Tasks/." "$HOME/Tasks/"
}
[[ $(($vscode_flag_as_int & $flags_as_int)) == $vscode_flag_as_int ]] && {
  cp -a "$tempShared/required/vscodevim/." "$HOME/vscodevim/"
  cp -a "$tempShared/required/configs/vscode/." VSC_SETTINGS_DESTINATION_PLACEHOLDER
}

# download vimplug if it does not exist
vim_plug_dir="$HOME/.vim/autoload";
vim_plug_path="$vim_plug_dir/plug.vim";
[[ -f "$vim_plug_path" ]] || {
  mkdir -p "$vim_plug_dir";
  curl -0Lk https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > "$vim_plug_path";
}

unset setupRoot
unset tempShared
unset tempThis
unset temp
unset flags
unset flags_as_int
unset vscode_flag_as_int
unset clipboard_flag_as_int
unset tasks_flag_as_int
unset vim_plug_dir
unset vim_plug_path

