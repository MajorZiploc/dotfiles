#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

tempShared="$SCRIPTPATH/temp/shared"
tempThis="$SCRIPTPATH/temp/this"

mkdir -p "$tempShared/"
cp -r "$SCRIPTPATH/../../../shared/" "$tempShared/"
mkdir -p "$tempThis/"
cp -r "$SCRIPTPATH/../" "$tempThis/"

find "$tempShared/" -type f -exec dos2unix {} \;
find "$tempThis/" -type f -exec dos2unix {} \;

mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swap
mkdir -p ~/vimfiles/plugin-settings
mkdir -p ~/bin
mkdir -p ~/clipboard
mkdir -p ~/bin
mkdir -p ~/Tasks
mkdir -p ~/vscodevim

cp -a "$tempShared/required/home/." ~/
cp -a "$tempThis/home/." ~/
cp -a "$tempShared/required/home_bin/." ~/bin/
cp -a "$tempShared/required/clipboard/." ~/clipboard/
cp -a "$tempShared/required/Tasks/." ~/Tasks/
cp -a "$tempShared/required/vscodevim/." ~/vscodevim/

# temp _vimrcterm
cp "$tempShared/required/home/_vimrcterm" "$SCRIPTPATH/_vimrcterm"
# replace .exe with nothing
sed -i.bak 's/bash\.exe/bash/g' "$SCRIPTPATH/_vimrcterm"
# override _vimrcterm
cp -a "$SCRIPTPATH/_vimrcterm" ~/_vimrcterm
rm "$SCRIPTPATH/_vimrcterm"
rm "$SCRIPTPATH/_vimrcterm.bak"

# temp _vsvimrc 
cp "$tempShared/required/vscodevim/_vsvimrc" "$SCRIPTPATH/_vsvimrc"
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

rm -r "$tempShared/"
rm -r "$tempThis/"

unset tempShared
unset tempThis

