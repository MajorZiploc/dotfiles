lua << EOF
  require('gitsigns').setup()
EOF

function! GitsignsStageHunk()
  let pwd = getcwd()
  if pwd =~ '/mnt/.*'
    execute 'Gitsigns stage_hunk'
    " wait 10ms to make sure staging hunk occurs before detaching
    sleep 10m
    execute 'Gitsigns detach_all'
    execute 'Gitsigns attach'
  else
    execute 'Gitsigns stage_hunk'
  endif
endfunction

nmap <leader>vs :call GitsignsStageHunk()<CR>
nmap <leader>vb :Gitsigns blame_line<CR>

nmap ]g :Gitsigns next_hunk<CR>
nmap [g :Gitsigns prev_hunk<CR>
