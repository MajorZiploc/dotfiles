nnoremap U <c-r>
nnoremap Y y$

" keep focus at center of screen
" nnoremap n nzzzv
" nnoremap N Nzzzv

" normal mode whitespace
" nnoremap <cr> o<esc>
" nnoremap <s-cr> O<esc>

" indenting
" nnoremap <tab> >>
" nnoremap <s-tab> <<
" vnoremap <tab> >
" vnoremap <s-tab> <
" inoremap <tab> <c-t>
" inoremap <s-tab> <c-d>

" split line (compliment of <s-j> to join)
" nnoremap <s-k> h<cr>^

" Helpful for with goto definition or reference doesnt work
" pair with fzf or find_* bash commands
nnoremap <silent> <leader>yw "+yiw

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
nnoremap <c-a> ggVG
nnoremap <c-s> :w<cr>
inoremap <c-s> <esc>:w<cr>a
nnoremap <c-z> u
vnoremap <c-x> "+d
vnoremap <c-c> "+y
nnoremap <c-v> "+p
vnoremap <c-v> "+p
inoremap <c-v> <esc>"+pa
nnoremap <c-w> :q<cr>
inoremap <c-w> <esc>:q<cr>
vnoremap <c-w> <esc>:q<cr>

" leader key
let mapleader=" "
" swap word under cursor with yank register
nnoremap <silent> <leader>s viwp
" swap word under cursor with system clipboard
nnoremap <silent> <leader>S viw"+p
" trim trailing spaces in file
nnoremap <silent> <leader>lt :%s/[ \t]\+$//<cr>

" true delete
vnoremap <leader>td "_d
" true delete followed by a paste
vnoremap <leader>tp "_dP

" enable backspace
set backspace=indent,eol,start

" indentation settings
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent

set scrolloff=8
set encoding=utf-8
set incsearch

" find settings
set ignorecase
set smartcase
set hlsearch
" clear search highlight with Backspace
nnoremap <silent> <bs> :noh<cr>

" max time between key presses to trigger a multi-key binding
set timeoutlen=300

set shell=VIM_SHELL_PLACEHOLDER

nmap <leader>gd :lua require('vscode-neovim').action('editor.action.revealDefinition')<cr>
nmap gr :lua require('vscode-neovim').action('editor.action.goToReferences')<cr>
nmap <leader>gr :lua require('vscode-neovim').action('editor.action.goToReferences')<cr>
nmap gi :lua require('vscode-neovim').action('editor.action.goToImplementation')<cr>
nmap <leader>gi :lua require('vscode-neovim').action('editor.action.goToImplementation')<cr>
nmap gq :lua require('vscode-neovim').action('editor.action.showHover')<cr>
vmap gq :lua require('vscode-neovim').action('editor.action.showHover')<cr>
nmap <leader>gq :lua require('vscode-neovim').action('editor.action.showHover')<cr>
vmap <leader>gq :lua require('vscode-neovim').action('editor.action.showHover')<cr>
nmap <leader>wi :lua require('vscode-neovim').action('editor.action.showHover')<cr>
vmap <leader>wi :lua require('vscode-neovim').action('editor.action.showHover')<cr>
nmap <s-k> :lua require('vscode-neovim').action('editor.action.showHover')<cr>
vmap gf :lua require('vscode-neovim').action('editor.action.formatSelection')<cr>
vmap <leader>gf :lua require('vscode-neovim').action('editor.action.formatSelection')<cr>
" NOTE: <c-w><c-q> has this effect
" doesnt seem to work
nmap <leader>bw :bd!<cr>

nmap <leader>fb :lua require('vscode-neovim').action('workbench.action.quickOpenPreviousRecentlyUsedEditor')<cr>
nmap <leader>fp :lua require('vscode-neovim').action('find-it-faster.findFiles')<cr>
nmap <leader>fa :lua require('vscode-neovim').action('find-it-faster.findWithinFiles')<cr>
nmap <leader>vi :lua require('vscode-neovim').action('workbench.view.scm')<cr>
vmap <leader>vr :lua require('vscode-neovim').action('git.revertSelectedRanges')<cr>
vmap <leader>vu :lua require('vscode-neovim').action('git.unstageSelectedRanges')<cr>
vmap <leader>vs :lua require('vscode-neovim').action('git.stageSelectedRanges')<cr>
nmap <leader>vb :lua require('vscode-neovim').action('gitlens.toggleZenMode')<cr>

" other file search types that may be useful (Look at keybindings in vscode for 'Recent' to find more)
" -- very similar to workbench.action.quickOpen
" :vsc workbench.action.showAllEditorsByMostRecentlyUsed
" -- is :ls
" :vsc workbench.action.quickOpenLeastRecentlyUsedEditor
" -- is like <ctrl>+<tab> on mac but with jk motions
" :vsc workbench.action.quickOpenPreviousRecentlyUsedEditor
" -- like workbench.action.quickOpenPreviousRecentlyUsedEditor but with search and falls back to not used files
" :vsc workbench.action.quickOpen

" TODO: make kindbinds json fallback for this
nmap <leader>fm :marks<cr>
nmap <leader>e :lua require('vscode-neovim').action('editor.action.marker.next')<cr>
nmap <leader>E :lua require('vscode-neovim').action('editor.action.marker.prev')<cr>
nmap [d :vsc editor.action.marker.prev<cr>
nmap ]d :vsc editor.action.marker.next<cr>

nmap [g :lua require('vscode-neovim').action('workbench.action.editor.previousChange')<cr>
nmap ]g :lua require('vscode-neovim').action('workbench.action.editor.nextChange')<cr>

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
" xmap <silent> . :normal .<cr>

" repeat macro command on a visual selection
" function! ExecuteMacroOverVisualRange()
"   echo "@".getcmdline()
"   execute ":'<,'>normal @" . nr2char(getchar())
" endfunction
" xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" save all dirty buffers
nmap <c-s> :wa<cr>

" copy to system clipboard
vnoremap <leader>cc "+y

" Patch H and L to have 3 padding from top
nnoremap <s-h> H3j
nnoremap <s-l> L3k<c-y>

" command mode polyfills for emacs terminal navigation
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
