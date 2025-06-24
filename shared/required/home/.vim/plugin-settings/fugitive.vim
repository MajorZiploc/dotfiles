" v namespace for 'version', used to use g for 'git' but coc keybindings
" typically use that and leads to conflicts
nmap <leader>vj :diffget //3<CR>
nmap <leader>vf :diffget //2<CR>
vmap <leader>vs :diffput<CR>
" brings up git status
nmap <leader>vi :horizontal topleft Git<CR>

" NOTE: in :diffput window
"   I on a file - interactive hunk stager
"   J on a file - expand diff summary of the file
"   dv on a file - open 3 way diff view in bottom
"   s on a file - stage a file
"     can make visual selection or do on the Unstaged tab for multiple or all files
"   u on a file - unstage a file
"     can make visual selection or do on the Staged tab for multiple or all files
