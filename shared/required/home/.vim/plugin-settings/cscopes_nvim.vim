nmap <leader>cs :call LoadQuickFixList(system('cscope -dL0 ' . expand('<cword>') . ' \| sed -E "s,(.*?) (GetType\|.global.) ([[:digit:]]+) (.*),\1:\3:1: \4,g"'))<CR>
