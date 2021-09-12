" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
let g:coc_global_extensions=['coc-json', 'coc-pyright', 'coc-sql', 'coc-tsserver', 'coc-css', 'coc-html']

nnoremap <leader>isd :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>irn <Plug>(coc-rename)
"
" Formatting selected code.
xmap <leader>ifs  <Plug>(coc-format-selected)
nmap <leader>ifs  <Plug>(coc-format-selected)
"
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>ica  <Plug>(coc-codeaction-selected)
nmap <leader>ica  <Plug>(coc-codeaction-selected)

