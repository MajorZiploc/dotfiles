#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swap
mkdir -p ~/vimfiles/plugin-settings
sudo mkdir -p ~/bin

cd ~
cp -a "$SCRIPTPATH/../../.shared/required/." .
cp -a "$SCRIPTPATH/../copy_content_to_home/." .
ls -A | xargs dos2unix

cd ~/bin
sudo cp -a "$SCRIPTPATH/../../.shared/home_bin/." .
sudo ls -A | xargs sudo dos2unix

# download vundle if it does not exist
vunDir='~/.vim/bundle/Vundle.vim'
[[ -d $DIR ]] || {
  cd ~/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  find . -exec readlink -f {} \; | xargs dos2unix
  cd ~
}
