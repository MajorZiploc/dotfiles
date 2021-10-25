set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'} " intellisense
Plug 'tpope/vim-surround' " manipulate surround chars
VIM_PLUGIN_INCLUDE_PLACEHOLDER

" Plug 'airblade/vim-rooter'
" Plug 'edkolev/tmuxline.vim' " prettier tmux
" Plug 'itchyny/lightline.vim' " status bar
" Plug 'airblade/vim-gitgutter' " git supporting plugin
" Plug 'OrangeT/vim-csharp'
" Plug 'chaoren/vim-wordmotion'
" Plug 'scrooloose/nerdtree' " filesystem explorer
"
" Alt to ctrlp,ripgrep,quickfix -- fzf is much better but doesnt always work
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
"
" " Alt to fzf
" Plug 'ctrlpvim/ctrlp.vim' " fuzzy file finder
" Plug 'jremmen/vim-ripgrep' " grepper, works in vim 8.1 and lower
" Plug 'stefandtw/quickfix-reflector.vim' " editable quickfix list for ripgrep

call plug#end()
filetype plugin indent on

" leader key
let mapleader = " "

so ~/vimfiles/plugin-settings/coc.vim
VIM_PLUGIN_SETTINGS_PLACEHOLDER

" so ~/vimfiles/plugin-settings/gitgutter.vim
" so ~/vimfiles/plugin-settings/wordmotion.vim

