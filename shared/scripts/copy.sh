#!/usr/bin/env bash

script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

# root of the os style configs being downloaded
setup_root="$1";

flags="$2";

home_dir="$3";
home_dir="${home_dir:-"$HOME"}";

temp="$setup_root/../temp";
temp_shared="$temp/shared";
temp_this="$temp/this";

"$script_path/create_temps.sh" "$setup_root" "$temp" "$temp_shared" "$temp_this";

home_wallpapers="${home_dir:?}/Pictures/Wallpapers"
mkdir -p "$home_wallpapers";
[[ ! -e "${home_wallpapers}/terminal_wallpaper.jpg" ]] && { cp "$temp_shared/pictures/terminal_wallpaper.jpg" "$home_wallpapers/terminal_wallpaper.jpg"; }

# call os specific substition flow script
test -f "$setup_root/scripts/substition.sh" && { "$setup_root/scripts/substition.sh" "$setup_root" "$temp" "$temp_shared" "$temp_this"; };

content_modifiers=("append" "prepend" "override" "new" "delete");
for content_modifier in ${content_modifiers[@]}; do
  "$temp_shared/scripts/edit_files.sh" "$temp" "$temp_shared" "$temp_this" "$content_modifier";
done;

"$temp_shared/scripts/ensure_client_paths.sh" "$setup_root" "$temp" "$temp_shared" "$temp_this" "$flags" "${home_dir:?}";

"$temp_shared/scripts/copy_content_to_client.sh" "$setup_root" "$temp" "$temp_shared" "$temp_this" "$flags" "${home_dir:?}";

rm -rf "${temp:?}/";

function make_vim_sh_envs {
  local zshenv="${home_dir:?}/.vim/bash_env.bash";
  local bashenv="${home_dir:?}/.vim/bash_env.zsh";
  local header="function main {";
  echo "$header" > "$zshenv";
  echo "$header" > "$bashenv";
  printf "shopt -s expand_aliases\n\n" >> "$zshenv";
  printf "setopt aliases\n\n" >> "$bashenv";
  local snippets_file="${home_dir:?}/.bashrc.d/portable/snippets.bash";
  local aliases_file="${home_dir:?}/.bashrc.d/portable/aliases.bash";
  local vim_bash_functions_file="${home_dir:?}/.bashrc.d/portable/functions_vim.bash";
  local padding="#################################";
  local begin="BEGIN";
  local body; body=$({
    echo "$padding $begin $vim_bash_functions_file $padding";
    cat "$vim_bash_functions_file";
    echo "$padding $begin $snippets_file $padding";
    cat "$snippets_file";
    echo "$padding $begin $aliases_file $padding";
    cat "$aliases_file";
  });
  echo "$body" >> "$zshenv";
  echo "$body" >> "$bashenv";
  local footer; footer=$(printf "\n}\n"; echo 'main $@ >/dev/null 2>&1;');
  echo "$footer" >> "$zshenv";
  echo "$footer" >> "$bashenv";
}

function make_slim_vimrc {
  local slim_vimrc="${home_dir:?}/.slim_vimrc";
  local header="\" Meant for use when sshing/docker/k8s containers";
  echo "$header" > "$slim_vimrc";
  local commonrc_file="${home_dir:?}/.vim/rc-settings/common.vim";
  local terminalrc_file="${home_dir:?}/.vim/rc-settings/terminal.vim";
  local padding="\" #################################";
  local begin="BEGIN";
  local body; body=$({ echo "$padding $begin $commonrc_file $padding"; cat "$commonrc_file"; echo "$padding $begin $terminalrc_file $padding"; cat "$terminalrc_file"; });
  echo "$body" >> "$slim_vimrc";
}

function make_all_in_one_shell_files {
  local zshenv="${home_dir:?}/all_in_one.zsh";
  local bashenv="${home_dir:?}/all_in_one.bash";
  local padding="#################################";
  local begin="BEGIN";
  local bash_body; bash_body=$(find "${home_dir:?}/.bashrc.d" -iname "*.bash" -type f -exec echo "$padding $begin {} $padding" \; -exec cat "{}" \; -exec echo "" \;);
  local zsh_body;
  zsh_body=$(find "${home_dir:?}/.zshrc.d" -iname "*.zsh" -type f -exec echo "$padding $begin {} $padding" \; -exec cat "{}" \; -exec echo "" \;);
  zsh_body+="
";
  zsh_body+=$(find "${home_dir:?}/.bashrc.d/portable" -iname "*.bash" -type f -exec echo "$padding $begin {} $padding" \; -exec cat "{}" \; -exec echo "" \;);
  echo "$zsh_body" > "$zshenv";
  echo "$bash_body" > "$bashenv";
}

make_vim_sh_envs;
make_slim_vimrc;
make_all_in_one_shell_files;

microsoft_dev_tools="${home_dir:?}/dev/microsoft";
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
unset home_dir;
unset content_modifiers;

