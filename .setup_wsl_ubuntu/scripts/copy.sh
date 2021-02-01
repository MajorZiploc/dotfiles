#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swap

# download vundle if it does not exist
vunDir='~/.vim/bundle/Vundle.vim'
[[ -d $DIR ]] || {
  cd ~/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  cd ~
}

cd ~
cp -a "$SCRIPTPATH/../../.shared/required/." .
cp -a "$SCRIPTPATH/../copy_content_to_home/." .
ls -A | xargs dos2unix

cd /usr/local/bin
sudo cp -a "$SCRIPTPATH/../../.shared/usr_local_bin/." .
sudo ls -A | xargs sudo dos2unix
