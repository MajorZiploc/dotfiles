if exists('g:vscode')
  " vscode asvetliakov.vscode-neovim extension
else
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath=&runtimepath
  source ~/.vimrc
endif

