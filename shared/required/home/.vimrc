" function! SourceIfExists(file)
"   if filereadable(expand(a:file))
"     exe 'source' a:file
"   endif
" endfunction

so ~/.slim_vimrc
so ~/.vim/rc-settings/plugins.vim
so ~/.vimrc_ext

" call SourceIfExists("~/.vimrc_ext")

