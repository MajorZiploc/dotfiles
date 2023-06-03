#!/usr/bin/env bash

script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

# root of the os style configs being downloaded
setup_root="$script_path/..";

flags="$1";
flags_as_int="$((2#$flags))";
vscode_flag_as_int="$((2#01))";
[[ -z "$flags" ]] && { flags='00'; }

echo "Running shared copy script... Output will be shown at the end all at once";
copy_script_output=$("$script_path/../../../shared/scripts/copy.sh" "$setup_root" "$flags" 2>&1);
did_copy_fail=$(echo "$copy_script_output" | grep 'No such file or directory');
did_copy_fail=$?;

[[ "$did_copy_fail" == "0" ]] && {
  echo "Failure shared copy output: $copy_script_output";
  echo "Looks like you dont have coreutils (linux polyfills) installed or sourced in your rc file"
  echo "  Trying backup method..."
  create_shared_temps_to_replace='cp -r "\$script_path/../../shared/" "\$temp/"';
  create_shared_temps_replace_with='cp -r "\$script_path/../../shared/" "\$temp_shared/"';
  gsed -E -i'' "s,$create_shared_temps_to_replace,$create_shared_temps_replace_with,g" "$script_path/../../../shared/scripts/create_temps.sh";
  copy_script_output=$("$script_path/../../../shared/scripts/copy.sh" "$setup_root" "$flags" 2>&1);
}

echo "$copy_script_output";
echo "Finished shared copy script";

[[ $(($vscode_flag_as_int & $flags_as_int)) == $vscode_flag_as_int ]] && {
  vscode_dir="$HOME/.vscoderc.d/";
  find "$vscode_dir" -type f -print0 | while read -r -d $'\0' file; do
    bname=`basename "$file"`;
    rm "$HOME/Library/Application Support/Code/User/$bname";
    ln -s "$vscode_dir/$bname" "$HOME/Library/Application Support/Code/User/$bname";
  done;
}

git restore "$script_path/../../../shared/scripts/create_temps.sh";

unset copy_script_output;
unset did_copy_fail;
unset setup_root;

