lua << EOF
  require('gitsigns').setup()
EOF

nmap <leader>vs :Gitsigns stage_hunk<CR>
