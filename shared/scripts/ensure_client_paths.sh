#!/usr/bin/env bash

script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

# root of the os style configs being downloaded
setup_root="$1";
temp="$2";
temp_shared="$3";
temp_this="$4";
flags="$5";
flags_as_int="$((2#$flags))";
vscode_flag_as_int="$((2#01))";
clipboard_flag_as_int="$((2#10))";
tasks_flag_as_int="$((2#100))";

mkdir -p "$HOME/.vim/bundle";
mkdir -p "$HOME/.vim/swap";
mkdir -p "$HOME/vimfiles/plugin-settings";
mkdir -p "$HOME/vimfiles/rc-settings";
[[ $(($clipboard_flag_as_int & $flags_as_int)) == $clipboard_flag_as_int ]] && {
  mkdir -p "$HOME/clipboard";
}
mkdir -p "$HOME/bin";
[[ $(($tasks_flag_as_int & $flags_as_int)) == $tasks_flag_as_int ]] && {
  mkdir -p "$HOME/Tasks";
}
[[ $(($vscode_flag_as_int & $flags_as_int)) == $vscode_flag_as_int ]] && {
  mkdir -p "$HOME/vscodevim";
  mkdir -p VSC_SETTINGS_DESTINATION_PLACEHOLDER;
}

unset setup_root;
unset temp_shared;
unset temp_this;
unset temp;
unset flags;
unset flags_as_int;
unset vscode_flag_as_int;
unset clipboard_flag_as_int;
unset tasks_flag_as_int;

