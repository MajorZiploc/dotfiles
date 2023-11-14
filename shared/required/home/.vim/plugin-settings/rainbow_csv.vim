let g:rbql_with_headers = 1
" ['python', 'js'] ; it appears that the default of python works best
let g:rbql_backend_language = 'python'
" Set to 1 to use system python interpreter for RBQL queries instead of the python interpreter built into your vim/neovim editor
let g:rbql_use_system_python = 1
" Same as csv but allows multiline fields
autocmd BufNewFile,BufRead *.csv set filetype=rfc_csv

" let g:disable_rainbow_hover = 1
" let g:rcsv_delimiters = ["\t", ",", "^", "~#~"]
" let g:disable_rainbow_csv_autodetect = 1
" let g:rcsv_max_columns = 30

" User Defined Functions (UDF)
" RBQL supports User Defined Functions
" You can define custom functions and/or import libraries in two special files:
"   ~/.rbql_init_source.py - for Python
"   ~/.rbql_init_source.js - for JavaScript

" Aligned csv (text align)
nnoremap <leader>ta <cmd>set filetype=csv<cr><cmd>:RainbowAlign<cr><cmd>set ft=rfc_csv<cr>
