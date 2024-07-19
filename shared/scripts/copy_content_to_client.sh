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

cp -a "$temp_shared/required/home/." "${home_dir:?}/";
cp -a "$temp_shared/required/home_bin/." "${home_dir:?}/bin/";
[[ $(($clipboard_flag_as_int & $flags_as_int)) == $clipboard_flag_as_int ]] && {
  cp -a "$temp_shared/required/clipboard/." "${home_dir:?}/clipboard/";
}
[[ $(($tasks_flag_as_int & $flags_as_int)) == $tasks_flag_as_int ]] && {
  cp -a "$temp_shared/required/Tasks/." "${home_dir:?}/Tasks/";
}
[[ $(($vscode_flag_as_int & $flags_as_int)) == $vscode_flag_as_int ]] && {
  cp -a "$temp_shared/required/vscodevim/." "${home_dir:?}/vscodevim/";
  cp -a "$temp_shared/required/configs/vscode/." VSC_SETTINGS_DESTINATION_PLACEHOLDER;
}

# download vimplug if it does not exist
vim_plug_dir="${home_dir:?}/.vim/autoload";
vim_plug_path="$vim_plug_dir/plug.vim";
[[ -f "$vim_plug_path" ]] || {
  mkdir -p "$vim_plug_dir";
  curl -0Lk https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > "$vim_plug_path";
}

# download tpm if it does not exist
tmux_plugin_dir="${home_dir:?}/.tmux/plugins";
tmux_plugin_manager_dir="$tmux_plugin_dir/tpm";
[[ -d "$tmux_plugin_manager_dir" ]] || {
  mkdir -p "$tmux_plugin_dir";
  git clone https://github.com/tmux-plugins/tpm "$tmux_plugin_manager_dir";
}

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
unset vim_plug_dir;
unset vim_plug_path;

