set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim' " package manager
Plugin 'neoclide/coc.nvim', {'branch': 'release'} " intellisense
Plugin 'tpope/vim-surround' " manipulate surround chars
VIM_PLUGIN_INCLUDE_PLACEHOLDER

" Plugin 'airblade/vim-rooter'
" Plugin 'edkolev/tmuxline.vim' " prettier tmux
" Plugin 'itchyny/lightline.vim' " status bar
" Plugin 'airblade/vim-gitgutter' " git supporting plugin
" Plugin 'OrangeT/vim-csharp'
" Plugin 'chaoren/vim-wordmotion'
" Plugin 'scrooloose/nerdtree' " filesystem explorer
" Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plugin 'junegunn/fzf.vim'

call vundle#end()
filetype plugin indent on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

" leader key
let mapleader = " "

so ~/vimfiles/plugin-settings/coc.vim
VIM_PLUGIN_SETTINGS_PLACEHOLDER

" so ~/vimfiles/plugin-settings/gitgutter.vim
" so ~/vimfiles/plugin-settings/wordmotion.vim

