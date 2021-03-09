#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

temp="$SCRIPTPATH/../../temp"
tempShared="$temp/shared"
tempThis="$SCRIPTPATH/../../temp/this"

mkdir -p "$tempShared/"
cp -r "$SCRIPTPATH/../../../shared/" "$temp/"
mkdir -p "$tempThis/"
cp -r "$SCRIPTPATH/../" "$tempThis/"

mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swap
mkdir -p ~/vimfiles/plugin-settings
mkdir -p ~/clipboard
mkdir -p ~/bin
mkdir -p /c/Tasks
mkdir -p /c/vscodevim

$tempShared/copy_scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "append"
$tempShared/copy_scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "prepend"
$tempShared/copy_scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "override"

# download vundle if it does not exist
vunDir="$HOME/.vim/bundle/Vundle.vim"
[[ -d $vunDir ]] || {
  cd ~/.vim/bundle
  git clone https://github.com/VundleVim/Vundle.vim.git "$vunDir"
  cd ~
}

cp -a "$SCRIPTPATH/../.ahk" ~/

cp -a "$tempShared/required/home/." ~/
cp -a "$tempShared/required/home_bin/." ~/bin/
cp -a "$tempShared/required/clipboard/." ~/clipboard/
cp -a "$tempShared/required/Tasks/." /c/Tasks/
cp -a "$tempShared/required/vscodevim/." /c/vscodevim/

rm -r "$temp/"

unset tempShared
unset tempThis
unset temp

