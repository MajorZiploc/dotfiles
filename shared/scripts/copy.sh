#!/usr/bin/env bash

script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

# root of the os style configs being downloaded
setup_root="$1";

flags="$2";

temp="$setup_root/../temp";
temp_shared="$temp/shared";
temp_this="$temp/this";

$script_path/create_temps.sh "$setup_root" "$temp" "$temp_shared" "$temp_this";

# call os specific substition flow script
test -f "$setup_root/scripts/substition.sh" && { $setup_root/scripts/substition.sh "$setup_root" "$temp" "$temp_shared" "$temp_this"; };

content_modifiers=("append" "prepend" "override" "new" "delete");
for content_modifier in ${content_modifiers[@]}; do
  $temp_shared/scripts/edit_files.sh "$temp" "$temp_shared" "$temp_this" "$content_modifier";
done;


$temp_shared/scripts/ensure_client_paths.sh "$setup_root" "$temp" "$temp_shared" "$temp_this" "$flags";

$temp_shared/scripts/copy_content_to_client.sh "$setup_root" "$temp" "$temp_shared" "$temp_this" "$flags";

rm -r "$temp/";

{ printf "shopt -s expand_aliases\n\n"; cat ~/.bashrc.d/portable/aliases.bash; } > ~/vimfiles/bash_env.bash;
{ printf "setopt aliases\n\n"; cat ~/.bashrc.d/portable/aliases.bash; } > ~/vimfiles/bash_env.zsh;

unset temp_shared;
unset temp_this;
unset temp;
unset setup_root;
unset flags;
unset content_modifiers;

