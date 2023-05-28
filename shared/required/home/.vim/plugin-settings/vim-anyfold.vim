" filetype plugin indent on " required (covered in terminal.vim)
" syntax on                 " required (covered in terminal.vim)

" autocmd Filetype * AnyFoldActivate               " activate for all filetypes
" or
" autocmd Filetype <your-filetype> AnyFoldActivate " activate for a specific filetype



nmap <leader>zf :AnyFoldActivate<cr>:set foldlevel=0<cr>
nmap <leader>zu :AnyFoldActivate<cr>:set foldlevel=99<cr>
