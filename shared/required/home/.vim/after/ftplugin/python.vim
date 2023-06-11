setlocal wildignore+=*.pyc,*/.venv/*,*/__pycache__/*

" TODO: fix include process
" setlocal include=^\\s*\\(from\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-\\}\\)*\\ze\\($\\|\ as\\)
"
" function! PyInclude(fname)
"   let parts = split(a:fname, ' import ')
"   let l = parts[0]
"   if len(parts) > 1
"     let r = parts[1]
"     let joined = join([l, r], '.')
"     let fp = substitute(joined, '\.', '/', 'g') . '.py'
"     let found = glob(fp, 1)
"     if len(found)
"       return found
"     endif
"   endif
"   return substitute(joined, '\.', '/', 'g') . '.py'
" endfunction

" setlocal includeexpr=PyInclude(v:fname)

setlocal define=^\\s*\\<\\(def\\\|class\\)\\>
