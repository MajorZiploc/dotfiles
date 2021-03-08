#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

mkdir -p "$SCRIPTPATH/temp/shared/"
cp -r "$SCRIPTPATH/../../../shared/" "$SCRIPTPATH/temp/shared/"
mkdir -p "$SCRIPTPATH/temp/this/"
cp -r "$SCRIPTPATH/../" "$SCRIPTPATH/temp/this/"

find "$SCRIPTPATH/temp/shared/" -type f -exec dos2unix {} \;
find "$SCRIPTPATH/temp/this/" -type f -exec dos2unix {} \;

mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swap
mkdir -p ~/vimfiles/plugin-settings
mkdir -p ~/bin
mkdir -p ~/clipboard
mkdir -p ~/bin
mkdir -p ~/Tasks
mkdir -p ~/vscodevim

cp -a "$SCRIPTPATH/temp/shared/required/home/." ~/
cp -a "$SCRIPTPATH/temp/this/home/." ~/
cp -a "$SCRIPTPATH/temp/shared/required/home_bin/." ~/bin/
cp -a "$SCRIPTPATH/temp/shared/required/clipboard/." ~/clipboard/
cp -a "$SCRIPTPATH/temp/shared/required/Tasks/." ~/Tasks/
cp -a "$SCRIPTPATH/temp/shared/required/vscodevim/." ~/vscodevim/

# temp _vimrcterm
cp "$SCRIPTPATH/temp/shared/required/home/_vimrcterm" "$SCRIPTPATH/_vimrcterm"
# replace .exe with nothing
sed -i.bak 's/bash\.exe/bash/g' "$SCRIPTPATH/_vimrcterm"
# override _vimrcterm
cp -a "$SCRIPTPATH/_vimrcterm" ~/_vimrcterm
rm "$SCRIPTPATH/_vimrcterm"
rm "$SCRIPTPATH/_vimrcterm.bak"

# temp _vsvimrc 
cp "$SCRIPTPATH/temp/shared/required/vscodevim/_vsvimrc" "$SCRIPTPATH/_vsvimrc"
# replace .exe with nothing
sed -i.bak 's/bash\.exe/bash/g' "$SCRIPTPATH/_vsvimrc"
# override _vsvimrc 
cp -a  "$SCRIPTPATH/_vsvimrc" ~/_vsvimrc
rm "$SCRIPTPATH/_vsvimrc"
rm "$SCRIPTPATH/_vsvimrc.bak"

# download vundle if it does not exist
vunDir="$HOME/.vim/bundle/Vundle.vim"
[[ -d $vunDir ]] || {
  cd ~/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git "$vunDir"
  find ~/.vim/bundle -type f -exec dos2unix {} \;
  cd ~
}

find "$SCRIPTPATH/temp/shared/" -type f -exec unix2dos {} \;
find "$SCRIPTPATH/temp/this/" -type f -exec unix2dos {} \;

rm -rf "$SCRIPTPATH/temp/shared/"
rm -rf "$SCRIPTPATH/temp/this/"

