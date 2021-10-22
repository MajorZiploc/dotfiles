#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"
temp="$2"
tempShared="$3"
tempThis="$4"

vsvimpath="$(echo "$HOME/vscodevim/_vsvimrc")"
find "$tempShared" -regextype egrep -iregex ".*\.json" -type f -exec sed -E -i'' "s,VSVIM_DIR_PLACEHOLDER,$vsvimpath,g" {} \;
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' 's,VIM_SHELL_PLACEHOLDER,/bin/bash,g' {} \;
vim_plugin_include="Plug 'ctrlpvim/ctrlp.vim' \" fuzzy file finder\nPlug 'mechatroner/rainbow_csv' \" csv highlighter and query engine\nPlug 'frazrepo/vim-rainbow' \" color pairing brakets and such\nPlug 'bling/vim-airline' \" status bar\nPlug 'vim-airline/vim-airline-themes' \" colors for status bar\nPlug 'jremmen/vim-ripgrep' \" grepper\nPlug 'stefandtw/quickfix-reflector.vim' \" editable quickfix list for ripgrep\nPlug 'tpope/vim-fugitive' \" git plugin";
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_PLUGIN_INCLUDE_PLACEHOLDER,$vim_plugin_include,g" {} \;
vim_plugset_path="so ~/vimfiles/plugin-settings/"
vim_plugin_settings="${vim_plugset_path}ctrlp.vim\n${vim_plugset_path}ripgrep.vim\n${vim_plugset_path}quickfix-reflector.vim\n\"${vim_plugset_path}fzf.vim\n${vim_plugset_path}rainbow_csv.vim\n${vim_plugset_path}airline-theme.vim\n${vim_plugset_path}fugitive.vim";
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_PLUGIN_SETTINGS_PLACEHOLDER,$vim_plugin_settings,g" {} \;
find "$tempShared" -regextype egrep -iregex ".*" -type f -exec sed -E -i'' "s,OS_PLACEHOLDER,ubuntu20.04,g" {} \;
vsc_settings_destination_placeholder="\$HOME/.config/Code/User/";
find "$tempShared" -regextype egrep -iregex ".*\.sh" -type f -exec sed -E -i'' "s,VSC_SETTINGS_DESTINATION_PLACEHOLDER,$vsc_settings_destination_placeholder,g" {} \;
tmuxps_paths_array_placeholder="(\"\$(find ~ -mindepth 1 -maxdepth 1 -regextype egrep -iregex \".*project.*\" -type d -not -path '*/__pycache__/*' -not -path '*/bin/*' -not -path '*/obj/*' -not -path '*/.git/*' -not -path '*/.svn/*' -not -path '*/node_modules/*' -not -path '*/.ionide/*' -not -path '*/.venv/*' 2>/dev/null)\")";
find "$tempShared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,TMUXPS_PATHS_ARRAY_PLACEHOLDER,$tmuxps_paths_array_placeholder,g" {} \;
cdf_fuzzy_finder_placeholder="fzf";
find "$tempShared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,CDF_FUZZY_FINDER_PLACEHOLDER,$cdf_fuzzy_finder_placeholder,g" {} \;
fuzzy_finder_placeholder="fzf";
find "$tempShared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,FUZZY_FINDER_PLACEHOLDER,$fuzzy_finder_placeholder,g" {} \;
bash_aliases_placeholder="# for opening a gui file explorer\nalias explorer=\"xdg-open\"\n# copy to clipboard\nalias clip=\"xclip -sel clip\"";
find "$tempShared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,BASH_ALIASES_PLACEHOLDER,$bash_aliases_placeholder,g" {} \;
extra_env_checks_placeholder="which fzf 2>\&1 2>/dev/null >/dev/null; [[ \"\$?\" != \"0\" ]] \&\& { ENV_NOTES=\"\$ENV_NOTES:Missing fzf (fuzzy finder)\"; }\nwhich python3 2>\&1 2>/dev/null >/dev/null; [[ \"\$?\" != \"0\" ]] \&\& { ENV_NOTES=\"\$ENV_NOTES:Missing python v3 \"; }\nwhich copyq 2>\&1 2>/dev/null >/dev/null; [[ \"\$?\" != \"0\" ]] \&\& { ENV_NOTES=\"\$ENV_NOTES:Missing copyq (clipboard manager)\"; }\n";
find "$tempShared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,EXTRA_ENV_CHECKS_PLACEHOLDER,$extra_env_checks_placeholder,g" {} \;
coc_plugins_placeholder="let g:coc_global_extensions=['coc-json', 'coc-pyright', 'coc-sql', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-sh']";
find "$tempShared" -regextype egrep -iregex ".*coc.*" -type f -exec sed -E -i'' "s/COC_PLUGINS_PLACEHOLDER/$coc_plugins_placeholder/g" {} \;

unset vsvimpath
unset vim_plugin_include
unset vim_plugset_path
unset vim_plugin_settings
unset tmuxps_paths_array_placeholder
unset cdf_fuzzy_finder_placeholder
unset fuzzy_finder_placeholder
unset bash_aliases_placeholder
unset extra_env_checks_placeholder
unset coc_plugins_placeholder
unset vsc_settings_destination_placeholder
unset setupRoot
unset tempShared
unset tempThis
unset temp

