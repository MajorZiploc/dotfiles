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

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
" ignore patterns for various search commands
set wildignore+=*.zip,*.png,*.jpg,*.gif,*.pdf,*DS_Store*,*/.git/*,*/node_modules/*,*/build/*,package-lock.json

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

function WriteIfPossibleThenQuitBuffer()
  :w
  :q!
endfunction
" save and quite
nmap <leader>wq :call WriteIfPossibleThenQuitBuffer()<cr>

" line nuke
nmap <leader>ln <cmd>%!to_less_blank_lines<cr>
vmap <leader>ln !to_less_blank_lines<cr>

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

nnoremap <leader>o :call GoToRecentBuffer('previous')<CR>
nnoremap <leader>i :call GoToRecentBuffer('next')<CR>

" create a scratch buffer
command! Scratch new | setlocal bt=nofile bh=wipe nobl noswapfile nu

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

" wrapper around gfind_files bash command for tight integration with vim
function! GFindFiles(...)
  let my_args = ''
  for my_arg in a:000
    let my_args = my_args . ' ' . '"' . my_arg . '"'
  endfor
  let cmd = 'gfind_files' . my_args
  let g:my_search_files = systemlist(cmd)
  if len(g:my_search_files) > 0
    execute 'find ' . g:my_search_files[0]
    echo g:my_search_files
    let g:my_search_files = g:my_search_files[1:] + [g:my_search_files[0]]
  else
    echohl WarningMsg
    echo "No results found for: " . cmd
    echohl None
  endif
endfunction

nmap <leader>cn :let my_search_files = my_search_files[1:] + [my_search_files[0]]<CR>:execute 'find ' . my_search_files[0]<CR>
nmap <leader>cp :let my_search_files = [my_search_files[-1]] + my_search_files[:-2]<CR>:execute 'find ' . my_search_files[-1]<CR>

" hidden files dont seem to be included if in a hidden directory
command! -nargs=1 VFindFiles let my_search_files_glob = globpath('.', '**/' . <q-args>, 1, 1) | if len(my_search_files_glob) | execute 'edit ' . my_search_files_glob[0] | endif

" bash finds raw
vmap <leader>fa <ESC>ogfind_in_files "(search_phrase)" ".*(file_pattern).*"<ESC>^
vmap <leader>ff <ESC>olet my_search_files = systemlist('gfind_files ".*(file_pattern).*" "(search_phrase)"')<ESC>^

function _RunPsql(selected_text, is_in_container)
  if (a:is_in_container)
    if (get(g:, 'use_env_vars_in_container', "false") == 'true')
      let _command_prepend = 'export PGDATABASE=' . $PGDATABASE . '; '
            \ . 'export PGUSER=' . $PGUSER . '; '
            \ . 'export PGPASSWORD=' . $PGPASSWORD . '; '
    endif
    let _command = 'psql --csv -c \"' . a:selected_text . '\"'
  else
    let _command = 'psql --csv -c "' . a:selected_text . '"'
  endif
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split]
endfunction

function! Run(...)
  let run_type = get(a:, 1, '')
  let debug = get(a:, 2, 'false')
  let debug_label = "DEBUG-> "
  " assumes the selected text will be yanked into the t register prior to Run
  let selected_text = @t
  if (trim(selected_text) == '')
    echohl WarningMsg
    echo "No selected_text stored in the t register! Use the vmap <leader>5 after selecting some text to run"
    echohl None
    return
  endif
  if (debug == 'true')
    echo debug_label "selected_text: " selected_text
  endif
  let is_in_container = !empty(get(g:, 'container_name', "")) && trim(g:container_name) != ''
  let _should_bottom_split = 0
  " check file_extension
  if (expand('%:e') == 'pgsql' || run_type == 'pgsql')
    let run_path = "pgsql"
    let case_values = _RunPsql(selected_text, is_in_container)
    let _command = get(case_values, 0, '')
    let _should_bottom_split = get(case_values, 1, 0)
  " elseif (&filetype == 'python' || run_type == 'python')
  "   echo "python run by filetype"
  else
    echohl WarningMsg
    echo "No matching run_path!"
    echohl None
  endif
  if (is_in_container)
    let _base_command = _command
    let _command = "cmd_wrap \"docker exec \\\"" . g:container_name . '\" '
    if (!empty(get(l:, '_command_prepend', '')))
      let _shell_command = " sh -c '"
            \ . _command_prepend
            \ . _base_command
            \ . "'"
      let _command = _command . _shell_command
    else
      let _command = _command . _base_command
    endif
    let _command = _command . '"'
  endif
  if (trim(_base_command) == '')
    echohl WarningMsg
    echo "No _base_command could be generated for your specific use case"
    echo "run_path: " run_path
    echo "_base_command: " _base_command
    echohl None
    return
  endif
  if (debug != 'true')
    let g:my_query_results = system(_command)
    if (_should_bottom_split)
      set splitbelow
      horizontal belowright Scratch
      put =g:my_query_results
      set filetype=rfc_csv
      execute "normal! ggdd"
      set splitbelow!
    else
      put =g:my_query_results
    endif
  else
    echo debug_label "run_path: " run_path
    echo debug_label "_command: " _command
    echo debug_label "_should_bottom_split: " _should_bottom_split
  endif
endfunction

vmap <leader>5 "ty:call Run()<CR>
vmap <leader>4 "ty:call Run('', 'true')<CR>

function! _RunConfigsPsql(...)
  let show_secrets = get(a:, 1, 0)
  echo show_secrets
  let is_in_container = !empty(get(g:, 'container_name', "")) && trim(g:container_name) != ''
  if (is_in_container)
    echo "container_name=" . '"' . g:container_name . '";'
  endif
  if (!empty(get(g:, 'use_env_vars_in_container', "")))
    echo "use_env_vars_in_container=" . '"' . g:use_env_vars_in_container . '";'
  endif
  if (is_in_container && get(g:, 'use_env_vars_in_container', "false") == 'true')
    echohl WarningMsg
    echo "NOTE: since container_name is set and use_env_vars_in_container='true'; PGUSER, PGPASSWORD, and PGDATABASE env vars will be used"
    echohl None
  elseif (is_in_container)
    echohl WarningMsg
    echo "NOTE: since container_name is set without use_env_vars_in_container='true'; PG* env vars wont be used"
    echohl None
  elseif (get(g:, 'use_env_vars_in_container', "false") == 'true')
    echohl WarningMsg
    echo "NOTE: since use_env_vars_in_container='true' without container_name being set; it will take no effect"
    echohl None
  endif
  echo "export PGHOST=" . '"' . $PGHOST . '";'
  echo "export PGPORT=" . '"' .  $PGPORT . '";'
  echo "export PGDATABASE=" . '"' .  $PGDATABASE . '";'
  echo "export PGUSER=" . '"' . $PGUSER . '";'
  let _password = "<OMITTED> pass 1 as first arg to see it"
  if (show_secrets != 0)
    let _password = $PGPASSWORD
  endif
  echo "export PGPASSWORD=" . '"' .  _password . '";'
endfunction

function! RunConfigs(...)
  let config_type = get(a:, 1, 0)
  let rest_of_args = a:000[1:]
  if (config_type == 'pgsql')
    call call('_RunConfigsPsql', rest_of_args)
  else
    echohl WarningMsg
    echo "Invalid config_type: " config_type
    echohl None
  endif
endfunction

" default splits to above
set splitbelow
set splitbelow!
