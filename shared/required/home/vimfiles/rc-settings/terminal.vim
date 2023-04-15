so ~/vimfiles/rc-settings/common.vim

" spellchecking
" set spelllang=en_us
" set spell

set mouse=a " allow mouse interactions
set hidden " allow opening of other files without saving current file

" Reduce extra space at bottom usually to show mode info or commands
set cmdheight=1

" write swap files here instead of beside each file
set directory=$HOME/.vim/swap//
" disable backups and swapfiles
set nobackup
set noswapfile

" wrap settings
" set textwidth=120
" set colorcolumn=+1

set colorcolumn=120 " set column ruler
" highlight ColorColumn ctermbg=lightcyan guibg=blue " recolor the column ruler

" set cursorline " set cursor highlight line
" a workaround for wsl terminals that are not windows terimanl
nmap <leader>6 <C-^>
" tabs creation in current directory
nmap <leader>tc :tabedit .<CR>
" close the currently focused buffer
nmap <leader>bw :bwipeout<CR>
" set shell
set shell=VIM_SHELL_PLACEHOLDER
" sets aliases for use in vim
let $BASH_ENV = VIM_BASH_ENV_PLACEHOLDER
set ruler " show file stats
set visualbell " blink cursor on error instead of beeping (grr)

" Resize window
nmap <C-w><left> <C-w><
nmap <C-w><right> <C-w>>
nmap <C-w><up> <C-w>+
nmap <C-w><down> <C-w>-

" Last line
set showmode
set showcmd

set ttyfast " rendering
set nocompatible " Don't try to be vi compatible

" refresh vim settings
" command! Sorc so $MYVIMRC
" command! Sorcvs so ~\_vsvimrc

" appearance
colorscheme elflord
if !has('nvim')
  " NOT A PERFECT SOLUTION. STILL LEADS TO PART WITH NON TRANSPARENT BG
  " Vim>=8 transparent bg
  autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
  " For Vim<8, replace EndOfBuffer by NonText
  " autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE
endif

set guifont=Consolas:h12
" menu colors
highlight Pmenu ctermbg=gray guibg=gray
highlight PmenuSel ctermbg=gray guibg=gray
highlight PmenuSbar ctermbg=gray guibg=gray
highlight Pmenu ctermbg=gray guibg=gray

" window
set nu " line numbers
" Display n lines above/below the cursor when scrolling with a mouse
set scrolloff=8
set encoding=utf-8
set incsearch
set guioptions-=m " remove menu bar
set guioptions-=T " remove toolbar
set laststatus=2 " airline always on
syntax on
" if has("gui_running")
  " GUI is running or is about to start.
  " set lines=999 columns=999
" else
  " set columns=120 lines=60
" endif

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
set wildmode=longest,list,full
" Added an extra select menu that shows what choice you are on for ,full
" set wildmenu

" remove language styles
let g:rust_recommended_style = 0
let g:python_recommended_style = 0

" required so that polyglot does not set the tab size. workaround to stop
" tabsize of 4 in fsharp so that I can use tab size 2
" MUST BE LOADED BEFORE THE POLYGLOT PLUGIN IS LOADED IN
let g:polyglot_disabled = ["autoindent"]

" syntax filetype associations
autocmd BufNewFile,BufRead Justfile set filetype=bash
autocmd BufNewFile,BufRead *.fs set filetype=fsharp
autocmd BufNewFile,BufRead *.fsx set filetype=fsharp

" Navigate to file: Allows open of non-existent files aswell
map <leader>nf :edit <cfile><cr>
