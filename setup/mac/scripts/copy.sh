#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$SCRIPTPATH/.."
create_shared_temps_to_replace='cp -r "\$SCRIPTPATH/../../shared/" "\$temp/"'
create_shared_temps_replace_with='cp -r "\$SCRIPTPATH/../../shared/" "\$tempShared/"'
gsed -E -i'' "s,$create_shared_temps_to_replace,$create_shared_temps_replace_with,g" "$SCRIPTPATH/../../../shared/scripts/create_temps.sh"

flags="$1"
flags_as_int="$((2#$flags))"
vscode_flag_as_int="$((2#01))"
[[ -z "$flags" ]] && { flags='00'; }

$SCRIPTPATH/../../../shared/scripts/copy.sh "$setupRoot" "$flags"

[[ $(($vscode_flag_as_int & $flags_as_int)) == $vscode_flag_as_int ]] && {
  vsc_file="$HOME/Library/Application Support/Code/User/settings.json"
  rm "$vsc_file";
  ln -s ~/settings.json "$vsc_file";
}

git restore "$SCRIPTPATH/../../../shared/scripts/create_temps.sh"

unset setupRoot

