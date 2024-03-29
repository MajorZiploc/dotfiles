" ctrl-a ctrl-q to select all and build quickfix list
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" NOTE: For literal string searches, prefix your search string with a single quote (')

" TODO: after a search, these commands will cd you back to the root of the project
"   WORKAROUND: you have to re `:cd` to where you were after ever search

" searches files by runing `$FZF_DEFAULT_COMMAND` if defined using in :pwd
" searches files like vscode
" should respect .gitignore
" CAN search only subdirectories
nmap <C-p> :OurFiles<CR>
" searches all files in project respecting .gitignore
" CANT search only subdirectories
nmap <C-f> :GFiles<CR>
" searches open buffers
nmap <leader>fb :Buffers<CR>

" search lines current buffers
nmap <leader>fi :BLines<CR>
" search lines in buffers
nmap <leader>ffi :Lines<CR>
" searches all lines of files in git repo
nmap <leader>fdsa :GGrep<CR>
" searches all lines of a more limited space of files in git repo, generally is to narrow
nmap <leader>fa :Rg<CR>
" searches all lines of all files in git repo, generally is to broad
nmap <leader>fda :Ag<CR>

" searches all commit
nmap <leader>fca :Commits<CR>
" searches commit related to the current buffer
nmap <leader>fci :BCommits<CR>
" search commands
nmap <leader>fcs :Commands<CR>
" searches open buffers and old buffers, generally is to broad
nmap <leader>fhb :History<CR>
" searches command history
nmap <leader>fhc :History:<CR>
" searches vims search history
nmap <leader>fhs :History/<CR>
" searches all tags
nnoremap <leader>fta :Tags<CR>
" searches tags related to current buffer
nnoremap <leader>fti :BTags<CR>
" searches marks
nnoremap <leader>fm :Marks<CR>

" Other useful commands
" :Filetypes -- to search file types

" Enable per-command history.
" ctrl-n and ctrl-p will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_tags_command = 'rg --files | ctags -R --links=no -L -'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.92, 'height': 0.92, 'yoffset': 0.5, 'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline --bind ctrl-a:select-all'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!**/.git/**'"

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" comment this one if you want to use the GGrep later on that only looks at file content
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" only search file content, not file name -- the {'options': '--delimiter : --nth 4..'} part
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(
  \   <q-args>, fzf#vim#with_preview({'dir': getcwd(), 'options': '--delimiter : --nth 4..'}), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \  "rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
  \  fzf#vim#with_preview({'dir': getcwd(), 'options': '--delimiter : --nth 4..'}), <bang>0)
" command! -bang -nargs=* GGrep
"   \ call fzf#vim#grep(
"   \   'git grep --line-number '.shellescape(<q-args>), 0,
"   \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0], 'options': '--delimiter : --nth 3..'}), <bang>0)

command! -bang -nargs=* OurFiles
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'dir': getcwd()}), <bang>0)
