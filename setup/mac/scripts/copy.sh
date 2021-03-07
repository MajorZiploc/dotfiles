#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swap
mkdir -p ~/vimfiles/plugin-settings
mkdir -p ~/bin
mkdir -p ~/clipboard
mkdir -p ~/bin
mkdir -p ~/Tasks
mkdir -p ~/vscodevim

cd ~
cp -a "$SCRIPTPATH/../../../shared/required/home/." .
cp -a "$SCRIPTPATH/../home/." .

cd ~/bin
cp -a "$SCRIPTPATH/../../.shared/required/home_bin/." .

cd ~/clipboard
cp -a "$SCRIPTPATH/../../../shared/required/clipboard/." ~/clipboard/

cd ~/Tasks
cp -a "$SCRIPTPATH/../../../shared/required/Tasks/." ~/Tasks/

cd ~/vscodevim
cp -a "$SCRIPTPATH/../../../shared/required/vscodevim/." ~/vscodevim/

# download vundle if it does not exist
vunDir="$HOME/.vim/bundle/Vundle.vim"
[[ -d $vunDir ]] || {
  cd ~/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git "$vunDir"
  cd ~
}
