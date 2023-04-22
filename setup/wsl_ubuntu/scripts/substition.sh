#!/usr/bin/env bash

script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

# root of the os style configs being downloaded
setup_root="$1";
temp="$2";
temp_shared="$3";
temp_this="$4";

vsvimpath="$(echo "$HOME/vscodevim/_vsvimrc")";
find "$temp_shared" -regextype egrep -iregex ".*\.json" -type f -exec sed -E -i'' "s,VSVIM_DIR_PLACEHOLDER,$vsvimpath,g" "{}" \;
vim_shell='~/bin/bash';
# NOTE: change to comment out the line containing VIM_SHELL_PLACEHOLDER if fzf starts erroring; commonly caused by bash_env file setting in vim if the env file has terminal output
find "$temp_shared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_SHELL_PLACEHOLDER,$vim_shell,g" "{}" \;
vim_plugin_include="Plug 'junegunn/fzf'\, \{ 'do': \{ -> fzf#install\(\) \} \} \" fuzzy finder\nPlug 'junegunn/fzf.vim'\nPlug 'airblade/vim-rooter' \" to help fzf determine project root";
vim_plugin_include="${vim_plugin_include}\nPlug 'mechatroner/rainbow_csv' \" csv highlighter and query engine\nPlug 'frazrepo/vim-rainbow' \" color pairing brakets and such (:RainbowToggle to turn on)\nPlug 'bling/vim-airline' \" status bar\nPlug 'vim-airline/vim-airline-themes' \" colors for status bar";
vim_plugin_include="${vim_plugin_include}\nPlug 'tpope/vim-fugitive' \" git plugin\nPlug 'sheerun/vim-polyglot' \" collection of language packs\nPlug 'tpope/vim-obsession' \" self managing n?vim sessions (Session.vim w/ :Obsession <file_name.vim>?/:Obsession! (start/discard current session respectively))\nPlug 'tpope/vim-commentary' \" comment/uncomment code (gcc\, etc)";
# nvim specific plugins
vim_plugin_include="${vim_plugin_include}\nif has\('nvim'\)\n  Plug 'neovim/nvim-lspconfig' \" intellisense\n  Plug 'deoplete-plugins/deoplete-lsp' \" for nvim-lspconfig\n  Plug 'Shougo/deoplete.nvim'\, \{ 'do': ':UpdateRemotePlugins' \} \" for nvim-lspconfig\n  Plug 'ionide/Ionide-vim'\, \{ 'do':  'make fsautocomplete'\, \} \" fsharp intellisense\n  Plug 'eddyekofo94/gruvbox-flat.nvim' \" color theme\n  Plug 'rrethy/vim-hexokinase'\, \{ 'do': 'make hexokinase' \} \" display code colors (requires go-lang)\n  Plug 'lewis6991/gitsigns.nvim' \" git gutter info\n  Plug 'glacambre/firenvim'\, \{ 'do': 'call firenvim#install\(0\)' \} \" use nvim in your browser for any text box\nendif";
find "$temp_shared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_PLUGIN_INCLUDE_PLACEHOLDER,$vim_plugin_include,g" "{}" \;
vim_plugset_path="so ~/.vim/plugin-settings/";
vim_plugin_settings="${vim_plugset_path}fzf.vim\n${vim_plugset_path}rainbow_csv.vim\n${vim_plugset_path}airline-theme.vim\n${vim_plugset_path}fugitive.vim";
# nvim specific settings
vim_plugin_settings="$vim_plugin_settings\nif has\('nvim'\)\n  ${vim_plugset_path}nvim-lspconfig.vim\n  ${vim_plugset_path}gruvbox_flat.vim\n  ${vim_plugset_path}gitsigns.vim\n  ${vim_plugset_path}firenvim.lua\nendif";
find "$temp_shared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -i'' "s,VIM_PLUGIN_SETTINGS_PLACEHOLDER,$vim_plugin_settings,g" "{}" \;
find "$temp_shared" -regextype egrep -iregex ".*" -type f -exec sed -E -i'' "s,OS_PLACEHOLDER,wsl_ubuntu,g" "{}" \;
vsc_settings_destination_placeholder="\$HOME/.config/Code/User/";
find "$temp_shared" -regextype egrep -iregex ".*\.sh" -type f -exec sed -E -i'' "s,VSC_SETTINGS_DESTINATION_PLACEHOLDER,$vsc_settings_destination_placeholder,g" "{}" \;
tmuxps_paths_array_placeholder="(\"\$(find ~ -mindepth 1 -maxdepth 1 -regextype egrep -iregex \".*(project|workspace).*\" -type d -not -path '*/__pycache__/*' -not -path '*/bin/*' -not -path '*/obj/*' -not -path '*/.git/*' -not -path '*/.svn/*' -not -path '*/node_modules/*' -not -path '*/.ionide/*' -not -path '*/.venv/*' 2>/dev/null)\" \"\$(find /mnt/c/Users -mindepth 2 -maxdepth 2 -regextype egrep -iregex \".*(project|workspace).*\" -type d -not -path '*/__pycache__/*' -not -path '*/bin/*' -not -path '*/obj/*' -not -path '*/.git/*' -not -path '*/.svn/*' -not -path '*/node_modules/*' -not -path '*/.ionide/*' 2>/dev/null)\")";
find "$temp_shared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,TMUXPS_PATHS_ARRAY_PLACEHOLDER,$tmuxps_paths_array_placeholder,g" "{}" \;
fuzzy_finder_cdf_placeholder="fzf";
find "$temp_shared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,FUZZY_FINDER_CDF_PLACEHOLDER,$fuzzy_finder_cdf_placeholder,g" "{}" \;
fuzzy_finder_placeholder="fzf";
find "$temp_shared" -regextype egrep -iregex ".*bash.*" -type f -exec sed -E -i'' "s,FUZZY_FINDER_PLACEHOLDER,$fuzzy_finder_placeholder,g" "{}" \;
coc_plugins_placeholder="let g:coc_global_extensions=['coc-json', 'coc-pyright', 'coc-sql', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-sh', 'coc-rust-analyzer', 'coc-omnisharp', 'coc-solargraph', 'coc-phpls', 'coc-java', 'coc-go', 'coc-explorer']";
find "$temp_shared" -regextype egrep -iregex ".*coc.*" -type f -exec sed -E -i'' "s/COC_PLUGINS_PLACEHOLDER/$coc_plugins_placeholder/g" "{}" \;
vim_bash_env_placeholder='"~/.vim/bash_env.bash"';
find "$temp_shared" -regextype egrep -iregex ".*vim.*" -type f -exec sed -E -i'' "s,VIM_BASH_ENV_PLACEHOLDER,$vim_bash_env_placeholder,g" "{}" \;

find "$temp_shared" -regextype egrep -iregex ".*sh" -type f -exec sed -E -i'' "s,(export )(FCEDIT|EDITOR|VISUAL).*?,\1\2='nvim'," "{}" \;
lvim_treesitter_and_mason_removals='"(gopls|gitignore)",';
find "$temp_shared" -regextype egrep -iregex ".*lvim.*" -type f -exec sed -E -i'' "/$lvim_treesitter_and_mason_removals/d" "{}" \;


unset lvim_treesitter_and_mason_removals;
unset vsvimpath;
unset vim_shell
unset vim_plugin_include;
unset vim_plugset_path;
unset vim_plugin_settings;
unset vsc_settings_destination_placeholder;
unset tmuxps_paths_array_placeholder;
unset fuzzy_finder_cdf_placeholder;
unset fuzzy_finder_placeholder;
unset coc_plugins_placeholder;
unset vim_bash_env_placeholder;
unset setup_root;
unset temp_shared;
unset temp_this;
unset temp;

