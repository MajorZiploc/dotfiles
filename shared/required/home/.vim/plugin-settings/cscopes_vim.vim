nmap <leader>cs :call LoadQuickFixList(system('cscope -dL0 ' . expand('<cword>') . ' \| sed -E "s,([^={}\+!@~\`#%^&*()\[\]\|]*?) (GetType\|MIN\|WITH\|KEY\|.global.\|' . expand('<cword>') . '\|[^[:blank:]]+?) ([[:digit:]]+) (.*),\1:\3:\4,g"'))<CR><CR>
