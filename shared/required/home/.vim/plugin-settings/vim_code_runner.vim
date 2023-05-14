vmap <leader>5 "ty:call VimCodeRunnerRun()<CR>
vmap <leader>4 "ty:call VimCodeRunnerRun('', 'true')<CR>
nmap <leader>5 :let @t = ''<CR>:call VimCodeRunnerRun()<CR>
nmap <leader>4 :let @t = ''<CR>:call VimCodeRunnerRun('', 'true')<CR>

let vim_code_runner_csv_type="rfc_csv"
