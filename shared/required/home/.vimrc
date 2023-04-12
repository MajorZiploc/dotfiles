function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

so ~/vimfiles/rc-settings/terminal.vim
so ~/vimfiles/rc-settings/plugins.vim

call SourceIfExists("~/.vimrc_ext")

