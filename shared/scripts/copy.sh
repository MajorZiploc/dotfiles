#!/usr/bin/env bash

script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

# root of the os style configs being downloaded
setup_root="$1";

flags="$2";

temp="$setup_root/../temp";
temp_shared="$temp/shared";
temp_this="$temp/this";

"$script_path/create_temps.sh" "$setup_root" "$temp" "$temp_shared" "$temp_this";

# call os specific substition flow script
test -f "$setup_root/scripts/substition.sh" && { "$setup_root/scripts/substition.sh" "$setup_root" "$temp" "$temp_shared" "$temp_this"; };

content_modifiers=("append" "prepend" "override" "new" "delete");
for content_modifier in ${content_modifiers[@]}; do
  "$temp_shared/scripts/edit_files.sh" "$temp" "$temp_shared" "$temp_this" "$content_modifier";
done;

"$temp_shared/scripts/ensure_client_paths.sh" "$setup_root" "$temp" "$temp_shared" "$temp_this" "$flags";

"$temp_shared/scripts/copy_content_to_client.sh" "$setup_root" "$temp" "$temp_shared" "$temp_this" "$flags";

rm -r "${temp:?}/";

{ printf "function main {\nshopt -s expand_aliases\n\n"; cat ~/.bashrc.d/portable/snippets.bash; cat ~/.bashrc.d/portable/aliases.bash; printf "\n}\n"; echo 'main >/dev/null 2>&1;'; } > ~/vimfiles/bash_env.bash;
{ printf "function main {\nsetopt aliases\n\n"; cat ~/.bashrc.d/portable/snippets.bash; cat ~/.bashrc.d/portable/aliases.bash; printf "\n}\n"; echo 'main >/dev/null 2>&1;'; } > ~/vimfiles/bash_env.zsh;

microsoft_dev_tools="$HOME/dev/microsoft";
chrome_debugger_dir="${microsoft_dev_tools}/vscode-chrome-debug";
node_debugger_dir="${microsoft_dev_tools}/vscode-node-debug2";
[[ ! -d  "$microsoft_dev_tools" ]] && { mkdir -p "$microsoft_dev_tools"; }

[[ ! -d  "$chrome_debugger_dir" ]] && {
  mkdir -p "$microsoft_dev_tools";
  cd "$microsoft_dev_tools";
  git clone https://github.com/microsoft/vscode-chrome-debug.git;
  cd "$chrome_debugger_dir";
  npm i;
  npm run build;
  cd "$script_path";
}

[[ ! -d  "$node_debugger_dir" ]] && {
  cd "$microsoft_dev_tools";
  git clone https://github.com/microsoft/vscode-node-debug2.git;
  cd "$node_debugger_dir";
  npm i;
  NODE_OPTIONS=--no-experimental-fetch npm run build;
  cd "$script_path";
}

unset microsoft_dev_tools;
unset chrome_debugger_dir;
unset temp_shared;
unset temp_this;
unset temp;
unset setup_root;
unset flags;
unset content_modifiers;

