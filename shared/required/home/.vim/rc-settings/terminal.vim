" spellchecking
" set spelllang=en_us
" set spell

" repeat macro command on a visual selection
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @" . nr2char(getchar())
endfunction
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" break text wrapped lines on spaces rather than inbetween words
set linebreak

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

" Search down into subfolders
" Provides tab-completion for all file-related tasks
" NOTE: the empty entry in the path means current working directory
set path+=**
" ignore patterns for various search commands
set wildignore+=*.zip,*.png,*.jpg,*.gif,*.pdf,*DS_Store*,*/.git/*,*/node_modules/*,*/build/*,package-lock.json

" appearance
" if !has('nvim')
  " NOT A PERFECT SOLUTION. STILL LEADS TO PART WITH NON TRANSPARENT BG
  " Vim>=8 transparent bg
  " autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
  " For Vim<8, replace EndOfBuffer by NonText
  " autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE
" endif
"

if has('nvim')
  autocmd vimenter * hi NormalNC guibg=NONE ctermbg=NONE
  autocmd vimenter * hi NormalSB guibg=NONE ctermbg=NONE
endif

colorscheme elflord
" menu colors
highlight Pmenu ctermbg=gray guibg=gray
highlight PmenuSel ctermbg=gray guibg=gray
highlight PmenuSbar ctermbg=gray guibg=gray
highlight Pmenu ctermbg=gray guibg=gray

set guifont=Consolas:h12

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
" enable netrw
filetype plugin on
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
" vertical preview split
let g:netrw_preview=1
" open split to the right
let g:netrw_alto=00

set more

" longest,list for bash like tab completion.
" Add ,full for more zsh style on third tab
set wildmode=longest,list,full
" Added an extra select menu that shows what choice you are on for ,full
" set wildmenu

" remove language styles
let g:rust_recommended_style = 0
" let g:python_recommended_style = 0

" required so that polyglot does not set the tab size. workaround to stop
" tabsize of 4 in fsharp so that I can use tab size 2
" MUST BE LOADED BEFORE THE POLYGLOT PLUGIN IS LOADED IN
let g:polyglot_disabled = ["autoindent"]

" syntax filetype associations
autocmd BufNewFile,BufRead Justfile set filetype=bash
autocmd BufNewFile,BufRead *.fs set filetype=fsharp
autocmd BufNewFile,BufRead *.fsx set filetype=fsharp
autocmd BufNewFile,BufRead *.pgsql set filetype=sql
autocmd BufNewFile,BufRead *.psql set filetype=sql
autocmd BufNewFile,BufRead *.mariadb set filetype=sql
autocmd BufNewFile,BufRead *.cassandra set filetype=sql
autocmd BufNewFile,BufRead *.mongodb set filetype=javascript
autocmd BufNewFile,BufRead *.mongo set filetype=javascript
autocmd BufNewFile,BufRead *.sqlite3 set filetype=sql
autocmd BufNewFile,BufRead *.sqlite set filetype=sql
autocmd BufNewFile,BufRead *.mssql set filetype=sql
autocmd BufNewFile,BufRead *.log set filetype=log
autocmd BufNewFile,BufRead *.godot set filetype=log
autocmd BufNewFile,BufRead *.git set filetype=git
autocmd BufNewFile,BufRead *.neo4j set filetype=cynpp
autocmd BufNewFile,BufRead *.gdshader set filetype=glsl
autocmd BufNewFile,BufRead *.ctags set filetype=ctags
autocmd BufNewFile,BufRead *.aspx set filetype=html

" enforce 2 space indents for markdown files
autocmd FileType markdown setlocal shiftwidth=2 softtabstop=2 expandtab
" enforce 2 space indents for godot (gdscript) files
autocmd FileType gdscript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType sql setlocal commentstring=--\ %s
autocmd FileType glsl setlocal commentstring=//\ %s
autocmd FileType gdscript setlocal commentstring=#\ %s
autocmd FileType log setlocal commentstring=;\ %s
autocmd FileType mysql setlocal commentstring=--\ %s
autocmd FileType ps1 setlocal commentstring=#\ %s
autocmd FileType autohotkey setlocal commentstring=;\ %s
autocmd FileType fsharp setlocal commentstring=//\ %s
autocmd FileType ctags setlocal commentstring=#\ %s
autocmd FileType text setlocal commentstring=#\ %s

" Navigate to file:
" Similar to the buildin gf but also allows open of non-existent files aswell
map <leader>nf :edit <cfile><cr>

" text nuke
nmap <leader>tn <cmd>%!to_less_blank_lines<cr>
vmap <leader>tn !to_less_blank_lines<cr>

" set grep command (Default: grep -n $* /dev/null)
set gp=git\ grep\ -Pin
" set gp=gfind_in_files
" use :grep with args of the fn set above
" use :copen to open a quickfix list of the results of the grep; cn, cp, cl work as expected

function! GoToRecentBuffer(direction)
  let limit = 0
  let startName = bufname('%')
  let nowName = bufname('%')
  while (startName == nowName) && (a:direction == 'previous' ? limit < 100 : limit <= 100)
    execute a:direction == 'previous' ? "normal! \<C-o>" : "normal! 1\<C-i>"
    let nowName = bufname('%')
    let limit += 1
  endwhile
  if startName == nowName
    echo "No " . a:direction . " file."
  endif
endfunction

nnoremap <leader>no :call GoToRecentBuffer('previous')<CR>
nnoremap <leader>ni :call GoToRecentBuffer('next')<CR>

" create a scratch buffer
command! Scratch new | setlocal bt=nofile bh=wipe nobl noswapfile nu | set filetype=log

" windo diffthis setup
nmap <leader>wd <C-w><C-v><CMD>Scratch<CR><C-w><C-j><C-w><C-q>

" if horizontal topleft doesnt seem to be working, use this:
" set splitbelow!

function! CreateSmallTopLeftScratch()
  horizontal topleft Scratch
  resize 10
endfunction

" new scratch
nmap <leader>ns :call CreateSmallTopLeftScratch()<CR>

" default splits to above
set splitbelow
set splitbelow!

nmap <leader>zi :set foldmethod=indent<cr>
nmap <leader>ze :set foldmethod=expr<cr>
nmap <leader>zm :set foldmethod=manual<cr>
nmap <leader>zs :set foldmethod=syntax<cr>
nmap <leader>zd :set foldmethod=diff<cr>
nmap <leader>zk :set foldmethod=marker<cr>

function! FoldHelper(fold_action)
  let og_foldmethod=&foldmethod
  let feedback="set foldmethod=" . og_foldmethod
  if (og_foldmethod == 'manual')
    set foldmethod=indent
    let feedback = feedback . " -> set foldmethod=indent"
  else
    let feedback = feedback . " -> ##(foldmethod must be manual for this switch to indent)##"
  endif
  execute 'normal! ' . a:fold_action
  let &foldmethod = og_foldmethod
  let feedback = feedback . " -> set foldmethod=" . og_foldmethod
  echo feedback
endfunction

nnoremap zr :call FoldHelper('zr')<cr>
nnoremap zR :call FoldHelper('zR')<cr>
nnoremap zm :call FoldHelper('zm')<cr>
nnoremap zM :call FoldHelper('zM')<cr>

function! LoadQuickFixList(content)
  if (a:content =~ ':\d\+:')
    cexpr a:content
  else
    call setqflist(map(split(a:content, '\n'), '{ "filename": v:val }'))
    cc
  endif
  copen
endfunction

nmap <leader>cp :call LoadQuickFixList(@+)<CR>
vmap <leader>cp "td:call LoadQuickFixList(@t)<CR>

function! LoadLocationFixList(content)
  if (a:content =~ ':\d\+:')
    lexpr a:content
  else
    let s:lines = split(a:content, '\n')
    let s:locations = []
    for line in s:lines
      let s:location = {'filename': line}
      call add(s:locations, s:location)
    endfor
    call setloclist(0, s:locations)
    lc
  endif
  lopen
endfunction

nmap <leader>lp :call LoadLocationFixList(@+)<CR>
vmap <leader>lp "td:call LoadLocationFixList(@t)<CR>

" extended regex instead of basic thing it uses by default
" nnoremap / /\v
" vnoremap / /\v

" wrapper around [ag]?find_files(_fuzz)? bash command for tight integration with vim
function MyFinder(find_command, quick_fix_list_style, ...)
  let my_args = ''
  for my_arg in a:000
    if (! (my_arg =~ '^".*"$' || my_arg =~ "^'.*'$"))
      let my_arg = "'" . my_arg . "'"
    endif
    let my_args = my_args . ' ' . my_arg
  endfor
  let cmd = a:find_command . my_args
  let my_search_files = system(cmd)
  if (my_search_files != '')
    if (a:quick_fix_list_style == 'global')
      call LoadQuickFixList(my_search_files)
    else
      call LoadLocationFixList(my_search_files)
    endif
  else
    echohl WarningMsg
    echo "No search results!"
    echohl None
  endif
endfunction

command! -nargs=+ GFindFiles call MyFinder('gfind_files', 'global', <f-args>)
command! -nargs=+ GFindFilesFuzz call MyFinder('gfind_files_fuzz', 'global', <f-args>)
command! -nargs=+ AFindFiles call MyFinder('afind_files', 'global', <f-args>)
command! -nargs=+ AFindFilesFuzz call MyFinder('afind_files_fuzz', 'global', <f-args>)
command! -nargs=+ FindFiles call MyFinder('find_files',  'global', <f-args>)
command! -nargs=+ FindFilesFuzz call MyFinder('find_files_fuzz', 'global', <f-args>)
command! -nargs=+ LGFindFiles call MyFinder('gfind_files', 'local', <f-args>)
command! -nargs=+ LGFindFilesFuzz call MyFinder('gfind_files_fuzz', 'local', <f-args>)
command! -nargs=+ LAFindFiles call MyFinder('afind_files', 'local', <f-args>)
command! -nargs=+ LAFindFilesFuzz call MyFinder('afind_files_fuzz', 'local', <f-args>)
command! -nargs=+ LFindFiles call MyFinder('file_files', 'local', <f-args>)
command! -nargs=+ LFindFilesFuzz call MyFinder('find_files_fuzz, 'local', <f-args>)

command! -nargs=+ GFindInFiles call MyFinder('gfind_in_files', 'global', <f-args>)
command! -nargs=+ GFindInFilesFuzz call MyFinder('gfind_in_files_fuzz', 'global', <f-args>)
command! -nargs=+ AFindInFiles call MyFinder('afind_in_files', 'global', <f-args>)
command! -nargs=+ AFindInFilesFuzz call MyFinder('afind_in_files_fuzz', 'global', <f-args>)
command! -nargs=+ FindInFiles call MyFinder('find_in_files, 'global', <f-args>)
command! -nargs=+ FindInFilesFuzz call MyFinder('find_in_files_fuzz, 'global', <f-args>)
command! -nargs=+ LGFindInFiles call MyFinder('gfind_in_files', 'local', <f-args>)
command! -nargs=+ LGFindInFilesFuzz call MyFinder('gfind_in_files_fuzz', 'local', <f-args>)
command! -nargs=+ LAFindInFiles call MyFinder('afind_in_files', 'local', <f-args>)
command! -nargs=+ LAFindInFilesFuzz call MyFinder('afind_in_files_fuzz', 'local', <f-args>)
command! -nargs=+ LFindInFiles call MyFinder('find_in_files, 'local', <f-args>)
command! -nargs=+ LFindInFilesFuzz call MyFinder('find_in_files_fuzz, 'local', <f-args>)

function! QuickFixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

command! -nargs=0 -bar Cargs execute 'args' QuickFixFilenames()

function! LocationFixFilenames()
  let buffer_numbers = {}
  for locfix_item in getloclist(0)
    let buffer_numbers[locfix_item['bufnr']] = bufname(locfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

function! LoadArgsList(content)
  let arg_list = split(a:content, '\n')
  let args_content = ''
  for arg in arg_list
    let next_arg = substitute(arg, '\v(.*):\d+:', '\=submatch(1)', '')
    let args_content = args_content . ' ' . next_arg
  endfor
  return args_content
endfunction

command! -nargs=1 -bar Pargs execute 'args' LoadArgsList(<args>)

function! TextAlignment()
  let og_filetype=&filetype
  if (og_filetype =~ '.*csv.*')
    set filetype=csv
    " REQUIRES: "mechatroner/rainbow_csv" 
    execute 'RainbowAlign'
  else
    echohl WarningMsg
    echo "!No text alignment strategy found for filetype: " og_filetype
    echohl None
  endif
  let &filetype = og_filetype
endfunction

" Aligned text (text align)
nnoremap <leader>ta :call TextAlignment()<cr>

" mainly for sshfs situation: store tmp like files locally rather than on the server to improve editor performance
set backupdir=~/.cache/vim/backup//
set directory=~/.cache/vim/swap//
set undodir=~/.cache/vim/undo//

command! E Explore
