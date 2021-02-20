#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swap
mkdir -p ~/vimfiles/plugin-settings
mkdir -p ~/bin

# download vundle if it does not exist
vunDir='~/.vim/bundle/Vundle.vim'
[[ -d $DIR ]] || {
  cd ~/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  cd ~
}

cp -a "$SCRIPTPATH/../../.shared/required/." ~/

cp -a "$SCRIPTPATH/../copy_content_to_home/." ~/

cp -a "$SCRIPTPATH/../.ahk" ~/

cp -a "$SCRIPTPATH/../clipboard" ~/

cp -a "$SCRIPTPATH/../../.shared/home_bin/." ~/bin/

cp -a "$SCRIPTPATH/../Tasks/." /c/Tasks/

cp -a "$SCRIPTPATH/../vscodevim/." /c/vscodevim/
