if exists('g:vscode')
  " vscode asvetliakov.vscode-neovim extension
  so ~/.config/vscodenvim/_vsvimrc.vim
else
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath=&runtimepath
  source ~/.vimrc
endif

