#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$SCRIPTPATH/.."

flags="$1"
[[ -z "$flags" ]] && { flags='00'; }
flags_as_int="$((2#$flags))"
all="$((2#111))"

$SCRIPTPATH/../../../shared/scripts/copy.sh "$setupRoot" "$flags"

[[ $(($all & $flags_as_int)) == $all ]] && {
  home_wallpapers="$HOME/Pictures/Wallpapers"
  mkdir -p "$home_wallpapers";
  cp "$SCRIPTPATH/../pictures/my-hero-toko-01.jpg" "$home_wallpapers";
  winterm_ubuntu_background_image_path_placeholder='"%USERPROFILE%\\\\Pictures\\\\Wallpapers\\\\my-hero-toko-01.jpg"';
  winterm_settings="$SCRIPTPATH/tmp_windows_terminal_settings.jsonc";
  cp "$SCRIPTPATH/../windows_terminal_settings.jsonc" "$winterm_settings";
  sed -E -i'' "s/WINTERM_UBUNTU_BACKGROUND_IMAGE_PATH_PLACEHOLDER/$winterm_ubuntu_background_image_path_placeholder/g" "$winterm_settings";
  cp "$winterm_settings" "$HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json";
  rm "$winterm_settings";
  unset winterm_ubuntu_background_image_path_placeholder
  unset home_wallpapers
  unset winterm_settings
}

unset setupRoot

