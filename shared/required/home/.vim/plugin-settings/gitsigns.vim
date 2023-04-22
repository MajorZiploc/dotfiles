lua << EOF
  require('gitsigns').setup()
EOF

nmap <leader>vs :Gitsigns stage_hunk<CR>
nmap <leader>vb :Gitsigns blame_line<CR>

nmap ]g :Gitsigns next_hunk<CR>
nmap [g :Gitsigns prev_hunk<CR>
