set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'} " intellisense
Plug 'tpope/vim-surround' " manipulate surround chars
Plug 'MajorZiploc/code_runner.vim' " run selected code chunks
Plug 'stefandtw/quickfix-reflector.vim' " editable quickfix
Plug 'sheerun/vim-polyglot' " collection of language packs
if (!has('nvim'))
  Plug 'junegunn/seoul256.vim' " no contrast color scheme
endif
VIM_PLUGIN_INCLUDE_PLACEHOLDER

" Plug 'airblade/vim-gitgutter' " git supporting plugin
" Plug 'OrangeT/vim-csharp'
" Plug 'chaoren/vim-wordmotion'
" Plug 'scrooloose/nerdtree' " filesystem explorer
"
" Alt to ctrlp,ripgrep,quickfix
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim' " works in vim 8.2 and neovim
" Plug 'airblade/vim-rooter'
"
" " Alt to fzf
" Plug 'ctrlpvim/ctrlp.vim' " fuzzy file finder, doesnt work on mac
" Plug 'jremmen/vim-ripgrep' " grepper, works in vim 8.1 and lower

call plug#end()
filetype plugin indent on

" leader key
let mapleader = " "

so ~/.vim/plugin-settings/coc.vim
so ~/.vim/plugin-settings/vim_code_runner.vim
if (!has('nvim'))
  so ~/.vim/plugin-settings/seoul256.vim
endif
VIM_PLUGIN_SETTINGS_PLACEHOLDER

