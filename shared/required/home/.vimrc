function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

so ~/vimfiles/rc-settings/terminal.vim
so ~/vimfiles/rc-settings/plugins.vim

" inoremap kj <esc>
" imap kj <esc>
" imap <tab> <esc>
imap <c-l> <esc>
imap <c-[> <esc>
" imap 1` <esc>
" imap `1 <esc>

call SourceIfExists("~/.vimrc_ext")

