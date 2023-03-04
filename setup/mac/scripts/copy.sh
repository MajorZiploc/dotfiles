#!/usr/bin/env bash

script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

# root of the os style configs being downloaded
setup_root="$script_path/..";
create_shared_temps_to_replace='cp -r "\$script_path/../../shared/" "\$temp/"';
create_shared_temps_replace_with='cp -r "\$script_path/../../shared/" "\$temp_shared/"';
gsed -E -i'' "s,$create_shared_temps_to_replace,$create_shared_temps_replace_with,g" "$script_path/../../../shared/scripts/create_temps.sh";

flags="$1";
flags_as_int="$((2#$flags))";
vscode_flag_as_int="$((2#01))";
[[ -z "$flags" ]] && { flags='00'; }

$script_path/../../../shared/scripts/copy.sh "$setup_root" "$flags";

[[ $(($vscode_flag_as_int & $flags_as_int)) == $vscode_flag_as_int ]] && {
  vscode_dir="$HOME/.vscoderc.d/";
  find "$vscode_dir" -type f -print0 | while read -d $'\0' file; do
    bname=`basename "$file"`;
    rm "$HOME/Library/Application Support/Code/User/$bname";
    ln -s "$vscode_dir/$bname" "$HOME/Library/Application Support/Code/User/$bname";
  done;
}

nvim "+:PlugInstall" "+:PlugUpgrade" "+:PlugUpdate" "+:CocInstall" "+:CocUpdate" 2>/dev/null;
# vim "+:PlugInstall" "+:PlugUpgrade" "+:PlugUpdate" "+:CocInstall" "+:CocUpdate" 2>/dev/null;

git restore "$script_path/../../../shared/scripts/create_temps.sh";

unset setup_root;

