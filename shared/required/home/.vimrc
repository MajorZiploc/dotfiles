function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

so ~/.vim/rc-settings/terminal.vim
so ~/.vim/rc-settings/plugins.vim

call SourceIfExists("~/.vimrc_ext")

