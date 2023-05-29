" filetype plugin indent on " required (covered in terminal.vim)
" syntax on                 " required (covered in terminal.vim)

" autocmd Filetype * AnyFoldActivate               " activate for all filetypes
" or
" autocmd Filetype <your-filetype> AnyFoldActivate " activate for a specific filetype


" using these keys to mimic how set foldmethod=indent works

nmap <leader>zM :AnyFoldActivate<cr>:set foldlevel=0<cr>
nmap <leader>zR :AnyFoldActivate<cr>:set foldlevel=99<cr>

nmap <leader>zm :AnyFoldActivate<cr>:let &foldlevel=&foldlevel-1<cr>
nmap <leader>zr :AnyFoldActivate<cr>:let &foldlevel=&foldlevel+1<cr>
