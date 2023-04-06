" v namespace for 'version', used to use g for 'git' but coc keybindings
" typically use that and leads to conflicts
nmap <leader>vj :diffget //3<CR>
nmap <leader>vf :diffget //2<CR>
vmap <leader>vs :diffput<CR>
" brings up git status
nmap <leader>vi :horizontal topleft Git<CR>

