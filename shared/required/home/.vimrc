function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

so ~/vimfiles/rc-settings/plugins.vim
so ~/vimfiles/rc-settings/terminal.vim
inoremap kj <esc>

call SourceIfExists("~/.vimrc_ext")

