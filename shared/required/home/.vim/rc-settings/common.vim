" leader key
let mapleader = " "

nnoremap U <c-r>
nnoremap Y y$

" keep focus at center of screen
" nnoremap n nzzzv
" nnoremap N Nzzzv

" Conflicts with ripgrep plugin
" normal mode whitespace
" nnoremap <cr> o<esc>
" nnoremap <s-cr> O<esc>

" Conflicts with <c-i> which is jump forward. <c-i> is considered the same as <tab>
" indenting
" nnoremap <tab> >>
" nnoremap <s-tab> <<
" vnoremap <tab> >
" vnoremap <s-tab> <
" inoremap <tab> <c-t>
" inoremap <s-tab> <c-d>

" split line (compliment of <s-j> to join)
" nnoremap <s-k> hr<cr>^

" navigation
" Using the original meaning of this key
" nnoremap H ^
" Using the original meaning of this key
" vnoremap H ^
" Using the original meaning of this key
" onoremap H ^
" Using the original meaning of this key
" nnoremap L $
" Using the original meaning of this key
" vnoremap L $
" Using the original meaning of this key
" onoremap L $

" control-keys for select all, undo, save, cut, copy, paste, quit
" This conflicts with screen's leader key
" nnoremap <c-a> ggVG
" Remove for consistency
" nnoremap <c-s> :w<cr>
" Remove for consistency
" inoremap <c-s> <esc>:w<cr>a
" This conflicts with putting a job in the background if we are using vim
" nnoremap <c-z> u
" Remove for consistency
" vnoremap <c-x> "+d
" Remove for consistency
" vnoremap <c-c> "+y
" This conflicts with visual block mode in vim
" nnoremap <c-v> "+p
" This conflicts with visual block mode in vim
" vnoremap <c-v> "+p
" Remove for consistency
" inoremap <c-v> <esc>"+pa

" swap word under cursor with yank register
" nnoremap <silent> <leader>s viwp
" swap word under cursor with system clipboard
" nnoremap <silent> <leader>S viw"+p
" trim trailing spaces in file
nnoremap <silent> <leader>lt :%s/[ \t]\+$/<cr>

" Helpful for with goto definition or reference doesnt work
" pair with fzf or find_* bash commands
nnoremap <silent> <leader>yw "+yiw

" true delete
vnoremap <leader>cd "_d
" true delete followed by a paste
vnoremap <leader>cp "_dP

" enable backspace
set backspace=indent,eol,start

" indentation settings
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent

" wrap settings
" set textwidth=120
" set colorcolumn=+1

" find settings
set ignorecase
set smartcase
set hlsearch
" clear search highlight with Backspace
nnoremap <silent> <bs> :noh<cr>

" max time between key presses to trigger a multi-key binding
set timeoutlen=300

" backup mappings for <esc>
" inoremap kj <esc>
" imap kj <esc>
" imap <tab> <esc>
imap <c-l> <esc>
imap <c-[> <esc>
" imap 1` <esc>
" imap `1 <esc>

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" repeat dot command on a visual selection
xmap <silent> . :normal .<cr>

" repeat macro command on a visual selection
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @" . nr2char(getchar())
endfunction
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" save all dirty buffers
nmap <c-s> :wa<cr>

" copy to system clipboard
vnoremap <leader>cc "+y
