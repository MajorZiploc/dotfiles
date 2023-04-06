lua << EOF
  require('gitsigns').setup()
EOF

nmap <leader>vs :Gitsigns stage_hunk<CR>
" TODO: remove this workaround for the in favor of using the prev line
" the prev line doesnt seem to work, it seems to use diffput regardless
nmap <leader>va :Gitsigns stage_hunk<CR>
