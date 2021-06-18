#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"
temp="$2"
tempShared="$3"
tempThis="$4"

vsvimpath="$(echo "$HOME/vscodevim/_vsvimrc")"
find "$tempShared" -regextype egrep -iregex ".*\.json" -type f -exec sed -E -i'' "s,VSVIM_DIR_PLACEHOLDER,$vsvimpath,g" {} \;
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' 's/VIM_PLUGIN_IMPORT_PLACEHOLDER/so ~\/_vim_plugins/g' {} \;
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' 's,VIM_SHELL_PLACEHOLDER,/bin/bash,g' {} \;
vim_plugin_import_ctrlp="Plugin 'ctrlpvim/ctrlp.vim' \" fuzzy file finder";
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_PLUGIN_IMPORT_CTRLP,$vim_plugin_import_ctrlp,g" {} \;
vim_plugin_import_rip_grep="Plugin 'jremmen/vim-ripgrep' \" grepper";
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_PLUGIN_IMPORT_RIP_GREP,$vim_plugin_import_rip_grep,g" {} \;
vim_plugin_import_quickfix="Plugin 'stefandtw/quickfix-reflector.vim' \" editable quickfix list for ripgrep";
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_PLUGIN_IMPORT_QUICKFIX,$vim_plugin_import_quickfix,g" {} \;
vim_plugin_import_fzf="\"Plugin 'junegunn/fzf'\, \{ 'do': \{ -> fzf#install\(\) \} \}\n\"Plugin 'junegunn/fzf.vim'\n\"Plugin 'airblade/vim-rooter'\n";
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_PLUGIN_IMPORT_FZF,$vim_plugin_import_fzf,g" {} \;
vim_plugin_settings_ctrlp="so ~/vimfiles/plugin-settings/ctrlp.vim";
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_PLUGIN_SETTINGS_CTRLP,$vim_plugin_settings_ctrlp,g" {} \;
vim_plugin_settings_rip_grep="so ~/vimfiles/plugin-settings/ripgrep.vim";
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_PLUGIN_SETTINGS_RIP_GREP,$vim_plugin_settings_rip_grep,g" {} \;
vim_plugin_settings_quickfix="so ~/vimfiles/plugin-settings/quickfix-reflector.vim";
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_PLUGIN_SETTINGS_QUICKFIX,$vim_plugin_settings_quickfix,g" {} \;
vim_plugin_settings_fzf="\"so ~/vimfiles/plugin-settings/fzf.vim";
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_PLUGIN_SETTINGS_FZF,$vim_plugin_settings_fzf,g" {} \;
find "$tempShared" -regextype egrep -iregex ".*" -type f -exec sed -E -i'' "s,OS_PLACEHOLDER,wsl_ubuntu20.04,g" {} \;
vsc_settings_destination_placeholder="\$HOME/.config/Code/User/";
find "$tempShared" -regextype egrep -iregex ".*\.sh" -type f -exec sed -E -i'' "s,VSC_SETTINGS_DESTINATION_PLACEHOLDER,$vsc_settings_destination_placeholder,g" {} \;
tmuxps_paths_array_placeholder="(\"\$(find ~ -mindepth 1 -maxdepth 1 -regextype egrep -iregex \".*project.*\" -not -path '*/__pycache__/*' -not -path '*/bin/*' -not -path '*/obj/*' -not -path '*/.git/*' -not -path '*/.svn/*' -not -path '*/node_modules/*' -not -path '*/.ionide/*' -not -path '*/.venv/*' 2>/dev/null)\" \"\$(find /mnt/c/Users -mindepth 2 -maxdepth 2 -regextype egrep -iregex \".*project.*\" -not -path '*/__pycache__/*' -not -path '*/bin/*' -not -path '*/obj/*' -not -path '*/.git/*' -not -path '*/.svn/*' -not -path '*/node_modules/*' -not -path '*/.ionide/*' 2>/dev/null)\")";
find "$tempShared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,TMUXPS_PATHS_ARRAY_PLACEHOLDER,$tmuxps_paths_array_placeholder,g" {} \;
fuzzy_finder_placeholder="fzf";
find "$tempShared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,FUZZY_FINDER_PLACEHOLDER,$fuzzy_finder_placeholder,g" {} \;

unset vsvimpath
unset vim_plugin_import_ctrlp
unset vim_plugin_import_rip_grep
unset vim_plugin_import_quickfix
unset vim_plugin_import_fzf
unset vim_plugin_settings_ctrlp
unset vim_plugin_settings_rip_grep
unset vim_plugin_settings_quickfix
unset vim_plugin_settings_fzf
unset vsc_settings_destination_placeholder
unset tmuxps_paths_array_placeholder
unset fuzzy_finder_placeholder
unset setupRoot
unset tempShared
unset tempThis
unset temp

