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

test -f "$temp_this/.ahk" && { cp -a "$temp_this/.ahk" "$HOME/"; }
cp -a "$temp_shared/required/home/." "$HOME/";
cp -a "$temp_shared/required/home_bin/." "$HOME/bin/";
[[ $(($clipboard_flag_as_int & $flags_as_int)) == $clipboard_flag_as_int ]] && {
  cp -a "$temp_shared/required/clipboard/." "$HOME/clipboard/";
}
[[ $(($tasks_flag_as_int & $flags_as_int)) == $tasks_flag_as_int ]] && {
  cp -a "$temp_shared/required/Tasks/." "$HOME/Tasks/";
}
[[ $(($vscode_flag_as_int & $flags_as_int)) == $vscode_flag_as_int ]] && {
  cp -a "$temp_shared/required/vscodevim/." "$HOME/vscodevim/";
  cp -a "$temp_shared/required/configs/vscode/." VSC_SETTINGS_DESTINATION_PLACEHOLDER;
}

# download vimplug if it does not exist
vim_plug_dir="$HOME/.vim/autoload";
vim_plug_path="$vim_plug_dir/plug.vim";
[[ -f "$vim_plug_path" ]] || {
  mkdir -p "$vim_plug_dir";
  curl -0Lk https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > "$vim_plug_path";
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
unset vim_plug_dir;
unset vim_plug_path;

