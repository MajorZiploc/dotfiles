setlocal suffixesadd+=.js,.jsx,.json
" setlocal isfname+=@-@
setlocal include=^\\s*[^\/]\\+\\(from\\\|require(['\"]\\)
setlocal wildignore+=**/node_modules/**,**/dist/**,package-lock.json
