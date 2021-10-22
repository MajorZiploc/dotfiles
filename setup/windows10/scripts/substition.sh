#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"
temp="$2"
tempShared="$3"
tempThis="$4"

vsvimpath="$(echo "$HOME/vscodevim/_vsvimrc" | sed -E 's,^/(\w),\U\1:,g' | sed -E 's,/,\\\\\\\\,g')"
find "$tempShared" -regextype egrep -iregex ".*\.json" -type f -exec sed -E -i'' "s,VSVIM_DIR_PLACEHOLDER,$vsvimpath,g" {} \;
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' 's,VIM_SHELL_PLACEHOLDER,/bin/bash.exe,g' {} \;
vim_plugin_include="Plug 'ctrlpvim/ctrlp.vim' \" fuzzy file finder";
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_PLUGIN_INCLUDE_PLACEHOLDER,$vim_plugin_include,g" {} \;
vim_plugset_path="so ~/vimfiles/plugin-settings/"
vim_plugin_settings="${vim_plugset_path}ctrlp.vim";
find "$tempShared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_PLUGIN_SETTINGS_PLACEHOLDER,$vim_plugin_settings,g" {} \;
find "$tempShared" -regextype egrep -iregex ".*" -type f -exec sed -E -i'' "s,OS_PLACEHOLDER,windows10,g" {} \;
vsc_settings_destination_placeholder="\$HOME/AppData/Roaming/Code/User/";
find "$tempShared" -regextype egrep -iregex ".*\.sh" -type f -exec sed -E -i'' "s,VSC_SETTINGS_DESTINATION_PLACEHOLDER,$vsc_settings_destination_placeholder,g" {} \;
tmuxps_paths_array_placeholder="(\"\$(find ~ -mindepth 1 -maxdepth 1 -regextype egrep -iregex \".*project.*\" -type d -not -path '*/__pycache__/*' -not -path '*/bin/*' -not -path '*/obj/*' -not -path '*/.git/*' -not -path '*/.svn/*' -not -path '*/node_modules/*' -not -path '*/.ionide/*' -not -path '*/.venv/*' 2>/dev/null)\")";
find "$tempShared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,TMUXPS_PATHS_ARRAY_PLACEHOLDER,$tmuxps_paths_array_placeholder,g" {} \;
cdf_fuzzy_finder_placeholder="gfind_files | fzy";
find "$tempShared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,CDF_FUZZY_FINDER_PLACEHOLDER,$cdf_fuzzy_finder_placeholder,g" {} \;
fuzzy_finder_placeholder="fzy";
find "$tempShared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,FUZZY_FINDER_PLACEHOLDER,$fuzzy_finder_placeholder,g" {} \;
bash_aliases_placeholder="# for opening a gui file explorer\nalias explorer=\"explorer.exe\"\n# copy to clipboard\nalias clip=\"clip.exe\"";
find "$tempShared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,BASH_ALIASES_PLACEHOLDER,$bash_aliases_placeholder,g" {} \;
extra_env_checks_placeholder="which fzy 2>\&1 2>/dev/null >/dev/null; [[ \"\$?\" != \"0\" ]] \&\& { ENV_NOTES=\"\$ENV_NOTES:Missing fzy (stdin fuzzy finder)\"; }\n[[ -z \$(python -V 2>/dev/null | egrep \"\\\b3\") ]] \&\& { ENV_NOTES=\"\$ENV_NOTES:Missing python v3 \"; }\n";
find "$tempShared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,EXTRA_ENV_CHECKS_PLACEHOLDER,$extra_env_checks_placeholder,g" {} \;
coc_plugins_placeholder="let g:coc_global_extensions=['coc-json', 'coc-pyright', 'coc-sql', 'coc-tsserver', 'coc-css', 'coc-html']";
find "$tempShared" -regextype egrep -iregex ".*coc.*" -type f -exec sed -E -i'' "s/COC_PLUGINS_PLACEHOLDER/$coc_plugins_placeholder/g" {} \;

unset vsvimpath
unset vim_plugin_include
unset vim_plugset_path
unset vim_plugin_settings
unset vsc_settings_destination_placeholder
unset tmuxps_paths_array_placeholder
unset cdf_fuzzy_finder_placeholder
unset fuzzy_finder_placeholder
unset bash_aliases_placeholder
unset extra_env_checks_placeholder
unset coc_plugins_placeholder
unset setupRoot
unset tempShared
unset tempThis
unset temp

