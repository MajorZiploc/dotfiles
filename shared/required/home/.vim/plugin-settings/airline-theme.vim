" vim-airline/vim-airline-themes settings
" more neon colored and some parts can be a little hard to read
" let g:airline_theme='zenburn'

" calm and easy to read with different colors for various modes
let g:airline_theme='base16'

" truncate long branch names to a fixed length
let g:airline#extensions#branch#displayed_head_limit = 10

" removes potentially large right most yellow bar about whitespace and mix indent info
let g:airline#extensions#whitespace#enabled = 0
