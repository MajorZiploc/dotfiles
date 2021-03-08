#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

temp="$SCRIPTPATH/../../temp"
tempShared="$temp/shared"
tempThis="$SCRIPTPATH/../../temp/this"

mkdir -p "$tempShared/"
cp -r "$SCRIPTPATH/../../../shared/" "$temp/"
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
cp -a "$tempShared/required/home_bin/." ~/bin/
cp -a "$tempShared/required/clipboard/." ~/clipboard/
cp -a "$tempShared/required/Tasks/." ~/Tasks/
cp -a "$tempShared/required/vscodevim/." ~/vscodevim/

cp -a "$tempThis/home/." ~/

IFS= ;
l=("home/_vimrcterm" "vscodevim/_vsvimrc");
for ele in ${l[@]};
  do
    b=$(basename "$ele")
    # temp file
    cp "$tempShared/required/$ele" "$SCRIPTPATH/$b"
    # replace .exe with nothing
    sed -i.bak 's/bash\.exe/bash/g' "$SCRIPTPATH/$b"
    # override file
    [[ "$ele" == *"home"* ]] && { cp "$SCRIPTPATH/$b" "$HOME/$b"; } || { cp "$SCRIPTPATH/$b" "$HOME/$ele"; }
    # cleanup
    rm "$SCRIPTPATH/$b"
    rm "$SCRIPTPATH/$b.bak"
    unset b
done;
unset IFS;

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

