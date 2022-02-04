so ~/vimfiles/rc-settings/common.vim

" set spelllang=en_us
" set spell

" Allow mouse interactions
set mouse=a

" Allow opening of other files without saving current file
set hidden

" write swap files here instead of beside each file
set directory=$HOME/.vim/swap//
" disable backups and swapfiles
set nobackup
set noswapfile

" wrap settings
" set textwidth=120
" set colorcolumn=+1

" set column ruler
set colorcolumn=120
" highlight ColorColumn ctermbg=lightcyan guibg=blue

" Resize window
nmap <C-w><left> <C-w><
nmap <C-w><right> <C-w>>
nmap <C-w><up> <C-w>+
nmap <C-w><down> <C-w>-

nmap <leader>6 <C-^>

" tabs creation in current directory
nmap <leader>tc :tabedit .<CR>

" Set shell
set shell=VIM_SHELL_PLACEHOLDER
" Sets aliases for use in vim
let $BASH_ENV = VIM_BASH_ENV_PLACEHOLDER

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Last line
set showmode
set showcmd

" Rendering
set ttyfast

" Don't try to be vi compatible
set nocompatible

" command aliases
command! Sorc so $MYVIMRC
command! Sorcvs so ~\_vsvimrc

" window/appearance
colorscheme elflord
set guifont=Consolas:h12
set nu " line numbers
" Display n lines above/below the cursor when scrolling with a mouse
set scrolloff=8
set encoding=utf-8
set incsearch
set guioptions-=m  " remove menu bar
set guioptions-=T  " remove toolbar
set laststatus=2 " airline always on
syntax on
" if has("gui_running")
  " GUI is running or is about to start.
  " set lines=999 columns=999
" else
  " set columns=120 lines=60
" endif

" syntax filetype associations
" au BufNewFile,BufRead *.nuspec setlocal ft=xml
" au BufNewFile,BufRead *.cls setlocal ft=vb

" toggle expandtab
function ToggleTab()
  if &expandtab
    set noexpandtab
    echo "indenting with tabs"
  else
    set expandtab
    echo "indenting with spaces"
  endif
endfunction
nnoremap <F9> mz:execute ToggleTab()<cr>`z

" show/hide whitespace chars
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
function ToggleWhiteSpace()
  if &list
    set nolist
    echo "not showing whitespace"
  else
    set list
    echo "showing whitespace"
  endif
endfunction
nnoremap <F10> mz:execute ToggleWhiteSpace()<cr>`z

" turn off automatic text wrapping
nnoremap <F11> :set fo-=t<cr>

" explorer settings
" remove netrw banner, Shift-i toggles the banner
let g:netrw_banner=0
let g:netrw_list_hide='^\./$,^\.\./$'
" let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+,\(^\|\s\s\)ntuser\.\S\+'
autocmd FileType netrw set nolist

" longest,list for bash like tab completion.
" Add ,full for more zsh style on third tab
set wildmode=longest,list ",full
" Added an extra select menu that shows what choice you are on for ,full
" set wildmenu

" menu colors
highlight Pmenu ctermbg=gray guibg=gray
highlight PmenuSel ctermbg=gray guibg=gray
highlight PmenuSbar ctermbg=gray guibg=gray
highlight Pmenu ctermbg=gray guibg=gray

" remove language styles
let g:rust_recommended_style = 0
let g:python_recommended_style = 0

" required so that polyglot does not set the tab size. workaround to stop
" tabsize of 4 in fsharp so that I can use tab size 2
" MUST BE LOADED BEFORE THE POLYGLOT PLUGIN IS LOADED IN
let g:polyglot_disabled = ["autoindent"]

autocmd BufNewFile,BufRead Justfile set filetype=bash

