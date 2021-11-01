#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"
temp="$2"
tempShared="$3"
tempThis="$4"

vsvimpath="$(echo "$HOME/vscodevim/_vsvimrc")"
find "$tempShared" -regextype egrep -iregex ".*\.json" -type f -exec sed -E -i'' "s,VSVIM_DIR_PLACEHOLDER,$vsvimpath,g" "{}" \;
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' 's,VIM_SHELL_PLACEHOLDER,/bin/bash,g' "{}" \;
vim_plugin_include="Plug 'junegunn/fzf'\, \{ 'do': \{ -> fzf#install\(\) \} \}\nPlug 'junegunn/fzf.vim'\nPlug 'airblade/vim-rooter'\nPlug 'mechatroner/rainbow_csv' \" csv highlighter and query engine\nPlug 'frazrepo/vim-rainbow' \" color pairing brakets and such\nPlug 'bling/vim-airline' \" status bar\nPlug 'vim-airline/vim-airline-themes' \" colors for status bar\nPlug 'tpope/vim-fugitive' \" git plugin";
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_PLUGIN_INCLUDE_PLACEHOLDER,$vim_plugin_include,g" "{}" \;
vim_plugset_path="so ~/vimfiles/plugin-settings/"
vim_plugin_settings="${vim_plugset_path}fzf.vim\n${vim_plugset_path}rainbow_csv.vim\n${vim_plugset_path}airline-theme.vim\n${vim_plugset_path}fugitive.vim";
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_PLUGIN_SETTINGS_PLACEHOLDER,$vim_plugin_settings,g" "{}" \;
find "$tempShared" -regextype egrep -iregex ".*" -type f -exec sed -E -i'' "s,OS_PLACEHOLDER,wsl_ubuntu20.04,g" "{}" \;
vsc_settings_destination_placeholder="\$HOME/.config/Code/User/";
find "$tempShared" -regextype egrep -iregex ".*\.sh" -type f -exec sed -E -i'' "s,VSC_SETTINGS_DESTINATION_PLACEHOLDER,$vsc_settings_destination_placeholder,g" "{}" \;
tmuxps_paths_array_placeholder="(\"\$(find ~ -mindepth 1 -maxdepth 1 -regextype egrep -iregex \".*(project|workspace).*\" -type d -not -path '*/__pycache__/*' -not -path '*/bin/*' -not -path '*/obj/*' -not -path '*/.git/*' -not -path '*/.svn/*' -not -path '*/node_modules/*' -not -path '*/.ionide/*' -not -path '*/.venv/*' 2>/dev/null)\" \"\$(find /mnt/c/Users -mindepth 2 -maxdepth 2 -regextype egrep -iregex \".*(project|workspace).*\" -type d -not -path '*/__pycache__/*' -not -path '*/bin/*' -not -path '*/obj/*' -not -path '*/.git/*' -not -path '*/.svn/*' -not -path '*/node_modules/*' -not -path '*/.ionide/*' 2>/dev/null)\")";
find "$tempShared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,TMUXPS_PATHS_ARRAY_PLACEHOLDER,$tmuxps_paths_array_placeholder,g" "{}" \;
fuzzy_finder_cdf_placeholder="fzf";
find "$tempShared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,FUZZY_FINDER_CDF_PLACEHOLDER,$fuzzy_finder_cdf_placeholder,g" "{}" \;
fuzzy_finder_placeholder="fzf";
find "$tempShared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,FUZZY_FINDER_PLACEHOLDER,$fuzzy_finder_placeholder,g" "{}" \;
extra_env_checks_placeholder="which fzf 2>\&1 2>/dev/null >/dev/null; [[ \"\$?\" != \"0\" ]] \&\& { ENV_NOTES=\"\$ENV_NOTES:Missing fzf (fuzzy finder)\"; }\n[[ -z \$(python -V 2>/dev/null | egrep \"\\\b3\") ]] \&\& { ENV_NOTES=\"\$ENV_NOTES:Missing python v3 \"; }\n";
find "$tempShared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,EXTRA_ENV_CHECKS_PLACEHOLDER,$extra_env_checks_placeholder,g" "{}" \;
coc_plugins_placeholder="let g:coc_global_extensions=['coc-json', 'coc-pyright', 'coc-sql', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-sh', 'coc-rust-analyzer']";
find "$tempShared" -regextype egrep -iregex ".*coc.*" -type f -exec sed -E -i'' "s/COC_PLUGINS_PLACEHOLDER/$coc_plugins_placeholder/g" "{}" \;
vim_bash_env_placeholder='"~/.bashrc"'
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -E -i'' "s,VIM_BASH_ENV_PLACEHOLDER,$vim_bash_env_placeholder,g" "{}" \;

unset vsvimpath
unset vim_plugin_include
unset vim_plugset_path
unset vim_plugin_settings
unset vsc_settings_destination_placeholder
unset tmuxps_paths_array_placeholder
unset fuzzy_finder_cdf_placeholder
unset fuzzy_finder_placeholder
unset extra_env_checks_placeholder
unset coc_plugins_placeholder
unset vim_bash_env_placeholder
unset setupRoot
unset tempShared
unset tempThis
unset temp

