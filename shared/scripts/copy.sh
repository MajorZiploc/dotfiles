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

function make_vim_sh_envs {
  local zshenv="$HOME/vimfiles/bash_env.bash";
  local bashenv="$HOME/vimfiles/bash_env.zsh";
  local header="function main {";
  echo "$header" > "$zshenv";
  echo "$header" > "$bashenv";
  printf "shopt -s expand_aliases\n\n" >> "$zshenv";
  printf "setopt aliases\n\n" >> "$bashenv";
  local snippets_file="$HOME/.bashrc.d/portable/snippets.bash";
  local aliases_file="$HOME/.bashrc.d/portable/aliases.bash";
  local padding="#################################";
  local begin="BEGIN";
  local body; body=$({ echo "$padding $begin $snippets_file $padding"; cat "$snippets_file"; echo "$padding $begin $aliases_file $padding"; cat "$aliases_file"; });
  echo "$body" >> "$zshenv";
  echo "$body" >> "$bashenv";
  local footer; footer=$(printf "\n}\n"; echo 'main >/dev/null 2>&1;');
  echo "$footer" >> "$zshenv";
  echo "$footer" >> "$bashenv";
}

function make_all_in_one_shell_files {
  local zshenv="$HOME/all_in_one.zsh";
  local bashenv="$HOME/all_in_one.bash";
  local header="function main {";
  echo "$header" > "$zshenv";
  echo "$header" > "$bashenv";
  printf "shopt -s expand_aliases\n\n" >> "$zshenv";
  printf "setopt aliases\n\n" >> "$bashenv";
  local padding="#################################";
  local begin="BEGIN";
  local bash_body; bash_body=$(find "$HOME/.bashrc.d/" -iname "*.bash" -type f -exec echo "$padding $begin {} $padding" \; -exec cat "{}" \; -exec echo "" \;);
  local zsh_body;
  zsh_body=$(find "$HOME/.bashrc.d/portable/" -iname "*.bash" -type f -exec echo "$padding $begin {} $padding" \; -exec cat "{}" \; -exec echo "" \;);
  zsh_body+=$(find "$HOME/.zshrc.d/" -iname "*.zsh" -type f -exec echo "$padding $begin {} $padding" \; -exec cat "{}" \; -exec echo "" \;);
  echo "$zsh_body" >> "$zshenv";
  echo "$bash_body" >> "$bashenv";
  local footer; footer=$(printf "\n}\n"; echo 'main >/dev/null 2>&1;');
  echo "$footer" >> "$zshenv";
  echo "$footer" >> "$bashenv";
}

make_vim_sh_envs;
make_all_in_one_shell_files;

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

