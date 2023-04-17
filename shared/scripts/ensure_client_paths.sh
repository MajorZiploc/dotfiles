#!/usr/bin/env bash

script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

# root of the os style configs being downloaded
setup_root="$1";
temp="$2";
temp_shared="$3";
temp_this="$4";
flags="$5";
home_dir="$6";
flags_as_int="$((2#$flags))";
vscode_flag_as_int="$((2#01))";
clipboard_flag_as_int="$((2#10))";
tasks_flag_as_int="$((2#100))";

mkdir -p "${home_dir:?}/.vim/bundle";
mkdir -p "${home_dir:?}/.vim/swap";
mkdir -p "${home_dir:?}/vimfiles/plugin-settings";
mkdir -p "${home_dir:?}/vimfiles/rc-settings";
[[ $(($clipboard_flag_as_int & $flags_as_int)) == $clipboard_flag_as_int ]] && {
  mkdir -p "${home_dir:?}/clipboard";
}
mkdir -p "${home_dir:?}/bin";
[[ $(($tasks_flag_as_int & $flags_as_int)) == $tasks_flag_as_int ]] && {
  mkdir -p "${home_dir:?}/Tasks";
}
[[ $(($vscode_flag_as_int & $flags_as_int)) == $vscode_flag_as_int ]] && {
  mkdir -p "${home_dir:?}/vscodevim";
  mkdir -p VSC_SETTINGS_DESTINATION_PLACEHOLDER;
}

touch ~/.vimrc_ext;

mkdir -p "/usr/local/bin";
mkdir -p "${home_dir:?}/.local/bin";

unset setup_root;
unset temp_shared;
unset temp_this;
unset temp;
unset flags;
unset home_dir;
unset flags_as_int;
unset vscode_flag_as_int;
unset clipboard_flag_as_int;
unset tasks_flag_as_int;

