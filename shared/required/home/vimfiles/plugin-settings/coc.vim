COC_PLUGINS_PLACEHOLDER

" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)

nnoremap <leader>wi :call <SID>show_documentation()<CR>
nnoremap <leader>gq :call <SID>show_documentation()<CR>
nmap <leader>ne <Cmd>CocCommand explorer<CR>

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
nmap <leader>rn <Plug>(coc-rename)
"
" Formatting selected code.
xmap <leader>gf  <Plug>(coc-format-selected)<CR>
nmap <leader>gf  <Plug>(coc-format-selected)<CR>
"
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

nmap <leader>E <Plug>(coc-diagnostic-prev)
nmap <leader>e <Plug>(coc-diagnostic-next)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

highlight CocWarningSign guifg=black
highlight CocErrorSign guifg=black
highlight CocSelectedText guifg=black
highlight CocWarningFloat guifg=black
highlight CocErrorFloat guifg=black
highlight CocHintSign guifg=black

" Can show an error on startup if opening directly to a *.env file without the <cr> at the end
autocmd BufNewFile,BufRead *.env execute ":silent! :CocDisable<cr>"

