let @t = ''
vmap <leader>5 "ty:call VimCodeRunnerRun()<CR>:let @t = ''<CR>
vmap <leader>4 "ty:call VimCodeRunnerRun('', 'true')<CR>:let @t = ''<CR>
nmap <leader>5 :call VimCodeRunnerRun()<CR>:let @t = ''<CR>
nmap <leader>4 :call VimCodeRunnerRun('', 'true')<CR>:let @t = ''<CR>

let vim_code_runner_csv_type="rfc_csv"
