" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" show hidden files in search results
let g:ctrlp_show_hidden = 1

