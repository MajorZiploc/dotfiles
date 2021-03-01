#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swap
mkdir -p ~/vimfiles/plugin-settings
mkdir -p ~/clipboard
mkdir -p ~/bin
mkdir -p /c/Tasks
mkdir -p /c/vscodevim

# download vundle if it does not exist
vunDir="$HOME/.vim/bundle/Vundle.vim"
[[ -d $vunDir ]] || {
  cd ~/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git "$vunDir"
  cd ~
}

cp -a "$SCRIPTPATH/../../../shared/required/." ~/
cp -a "$SCRIPTPATH/../home/." ~/
cp -a "$SCRIPTPATH/../.ahk" ~/
cp -a "$SCRIPTPATH/../../../shared/clipboard/" ~/clipboard/
cp -a "$SCRIPTPATH/../../../shared/home_bin/." ~/bin/
cp -a "$SCRIPTPATH/../../../shared/Tasks/." /c/Tasks/
cp -a "$SCRIPTPATH/../../../shared/vscodevim/." /c/vscodevim/
