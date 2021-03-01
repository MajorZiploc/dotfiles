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
cp -a "$SCRIPTPATH/../../../shared/required/." .
cp -a "$SCRIPTPATH/../home/." .
ls -A | xargs dos2unix

cd ~/bin
cp -a "$SCRIPTPATH/../../.shared/home_bin/." .
ls -A | xargs dos2unix

cd ~/clipboard
cp -a "$SCRIPTPATH/../../../shared/clipboard/" ~/clipboard/
ls -A | xargs dos2unix

cd ~/Tasks
cp -a "$SCRIPTPATH/../../../shared/Tasks/." ~/Tasks/
ls -A | xargs dos2unix

cd ~/vscodevim
cp -a "$SCRIPTPATH/../../../shared/vscodevim/." ~/vscodevim/
ls -A | xargs dos2unix

# download vundle if it does not exist
vunDir='~/.vim/bundle/Vundle.vim'
[[ -d $DIR ]] || {
  cd ~/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  find . -exec readlink -f {} \; | xargs dos2unix
  cd ~
}
