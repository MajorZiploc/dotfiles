#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"
temp="$2"
tempShared="$3"
tempThis="$4"

vsvimpath="$(echo "$HOME/vscodevim/_vsvimrc")"
find -E "$tempShared" -iregex ".*\.json" -type f -exec gsed -E -i'' "s,VSVIM_DIR_PLACEHOLDER,$vsvimpath,g" {} \;
find -E "$tempShared" -iregex ".*vim.*" -type f -exec gsed -i'' 's,VIM_SHELL_PLACEHOLDER,/bin/zsh,g' {} \;
find -E "$tempShared" -iregex ".*vim.*" -type f -exec gsed -i'' 's,\.bashrc,.zshrc_core,g' {} \;
vim_plugin_include="Plug 'junegunn/fzf'\, \{ 'do': \{ -> fzf#install\(\) \} \}\nPlug 'junegunn/fzf.vim'\nPlug 'airblade/vim-rooter'\nPlug 'mechatroner/rainbow_csv' \" csv highlighter and query engine\nPlug 'frazrepo/vim-rainbow' \" color pairing brakets and such\nPlug 'bling/vim-airline' \" status bar\nPlug 'vim-airline/vim-airline-themes' \" colors for status bar\nPlug 'tpope/vim-fugitive' \" git plugin";
find -E "$tempShared" -iregex ".*vim.*" -type f -exec gsed -i'' "s,VIM_PLUGIN_INCLUDE_PLACEHOLDER,$vim_plugin_include,g" {} \;
vim_plugset_path="so ~/vimfiles/plugin-settings/"
vim_plugin_settings="${vim_plugset_path}fzf.vim\n${vim_plugset_path}rainbow_csv.vim\n${vim_plugset_path}airline-theme.vim\n${vim_plugset_path}fugitive.vim";
find -E "$tempShared" -iregex ".*vim.*" -type f -exec gsed -i'' "s,VIM_PLUGIN_SETTINGS_PLACEHOLDER,$vim_plugin_settings,g" {} \;
find -E "$tempShared" -iregex ".*" -type f -exec gsed -E -i'' "s,OS_PLACEHOLDER,mac,g" {} \;
vsc_settings_destination_placeholder="$HOME/.vscoderc.d/";
find -E "$tempShared" -iregex ".*\.sh" -type f -exec gsed -E -i'' "s,VSC_SETTINGS_DESTINATION_PLACEHOLDER,$vsc_settings_destination_placeholder,g" {} \;
tmuxps_paths_array_placeholder="(\"\$(find ~ -mindepth 1 -maxdepth 1 -iregex \".*project.*\" -type d -not -path '*/__pycache__/*' -not -path '*/bin/*' -not -path '*/obj/*' -not -path '*/.git/*' -not -path '*/.svn/*' -not -path '*/node_modules/*' -not -path '*/.ionide/*' -not -path '*/.venv/*' 2>/dev/null)\")";
find -E "$tempShared" -iregex ".*bash.*" -type f -exec gsed -E -i'' "s,TMUXPS_PATHS_ARRAY_PLACEHOLDER,$tmuxps_paths_array_placeholder,g" {} \;
fuzzy_finder_placeholder="fzf";
find -E "$tempShared" -iregex ".*bash.*" -type f -exec gsed -E -i'' "s,FUZZY_FINDER_PLACEHOLDER,$fuzzy_finder_placeholder,g" {} \;
bash_aliases_placeholder="# for opening a gui file explorer\nalias explorer=\"xdg-open\"\n# copy to clipboard\nalias clip=\"pbcopy\"";
find -E "$tempShared" -iregex ".*bash.*" -type f -exec gsed -E -i'' "s,BASH_ALIASES_PLACEHOLDER,$bash_aliases_placeholder,g" {} \;
extra_env_checks_placeholder="which fzf 2>\&1 >/dev/null; [[ \"\$?\" != \"0\" ]] \&\& { ENV_NOTES=\"\$ENV_NOTES:Missing fzf (fuzzy finder)\"; }\nwhich python3 2>\&1 >/dev/null; [[ \"\$?\" != \"0\" ]] \&\& { ENV_NOTES=\"\$ENV_NOTES:Missing python v3 \"; }\n";
find -E "$tempShared" -iregex ".*bash.*" -type f -exec gsed -E -i'' "s,EXTRA_ENV_CHECKS_PLACEHOLDER,$extra_env_checks_placeholder,g" {} \;
coc_plugins_placeholder="let g:coc_global_extensions=['coc-json', 'coc-pyright', 'coc-sql', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-sh']";
find -E "$tempShared" -iregex ".*coc.*" -type f -exec gsed -E -i'' "s/COC_PLUGINS_PLACEHOLDER/$coc_plugins_placeholder/g" {} \;
find -E "$tempShared" -type f -exec gsed -E -i'' "s/find(.*?)-regextype egrep/find -E\1/g" {} \;
find -E "$tempShared" -iregex ".*functions\.bash" -type f -exec gsed -E -i'' "s/-exec sed/-exec gsed/g" {} \;
# example of deleting bak files
# find "$tempShared" -iregex '.*\.bak$' -type f -exec rm {} \;

unset vsvimpath
unset vim_plugin_include
unset vim_plugset_path
unset vim_plugin_settings
unset tmuxps_paths_array_placeholder
unset fuzzy_finder_placeholder
unset bash_aliases_placeholder
unset extra_env_checks_placeholder
unset coc_plugins_placeholder
unset vsc_settings_destination_placeholder
unset setupRoot
unset tempShared
unset tempThis
unset temp

