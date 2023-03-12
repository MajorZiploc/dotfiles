#!/usr/bin/env bash

script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

# root of the os style configs being downloaded
setup_root="$script_path/..";

flags="$1";
[[ -z "$flags" ]] && { flags='00'; }

"$script_path/../../../shared/scripts/copy.sh" "$setup_root" "$flags";

if which lvim; then
  lvim "+:PackerInstall" "+:PackerUpdate" 2>/dev/null;
elif which nvim; then
  nvim "+:PlugInstall" "+:PlugUpgrade" "+:PlugUpdate" "+:CocInstall" "+:CocUpdate" 2>/dev/null;
elif which vim; then
  vim "+:PlugInstall" "+:PlugUpgrade" "+:PlugUpdate" "+:CocInstall" "+:CocUpdate" 2>/dev/null;
fi

unset setup_root;

