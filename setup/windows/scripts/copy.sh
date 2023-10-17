#!/usr/bin/env bash

script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setup_root="$script_path/.."

flags="$1"
[[ -z "$flags" ]] && { flags='00'; }
flags_as_int="$((2#$flags))"
all="$((2#111))"

home_dir="$2";
home_dir="${home_dir:-"$HOME"}";

"$script_path/../../../shared/scripts/copy.sh" "$setup_root" "$flags" "${home_dir:?}";

[[ $(($all & $flags_as_int)) == $all ]] && {
  winterm_ubuntu_background_image_path_placeholder='"%USERPROFILE%\\\\Pictures\\\\Wallpapers\\\\my-hero-toko-01.jpg"';
  winterm_settings="$script_path/tmp_windows_terminal_settings.jsonc";
  cp "$script_path/../windows_terminal_settings.jsonc" "$winterm_settings";
  sed -E -i'' "s/WINTERM_UBUNTU_BACKGROUND_IMAGE_PATH_PLACEHOLDER/$winterm_ubuntu_background_image_path_placeholder/g" "$winterm_settings";
  cp "$winterm_settings" "${home_dir:?}/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json";
  rm "$winterm_settings";
}

cp "$home_dir/.config/nvim/init.vim" "$home_dir/AppData/Local/nvim/init.vim";

unset winterm_ubuntu_background_image_path_placeholder;
unset home_wallpapers;
unset winterm_settings;
unset setup_root;
unset flags;
unset home_dir;

