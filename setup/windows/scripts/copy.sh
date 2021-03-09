#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

temp="$SCRIPTPATH/../../temp"
tempShared="$temp/shared"
tempThis="$SCRIPTPATH/../../temp/this"

mkdir -p "$tempShared/"
cp -r "$SCRIPTPATH/../../../shared/" "$temp/"
mkdir -p "$tempThis/"
cp -r "$SCRIPTPATH/../" "$tempThis/"

mkdir -p "$HOME/.vim/bundle"
mkdir -p "$HOME/.vim/swap"
mkdir -p "$HOME/vimfiles/plugin-settings"
mkdir -p "$HOME/clipboard"
mkdir -p "$HOME/bin"
mkdir -p "/c/Tasks"
mkdir -p "/c/vscodevim"

$tempShared/copy_scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "append"
$tempShared/copy_scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "prepend"
$tempShared/copy_scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "override"

cp -a "$SCRIPTPATH/../.ahk" "$HOME/"

cp -a "$tempShared/required/home/." "$HOME/"
cp -a "$tempShared/required/home_bin/." "$HOME/bin/"
cp -a "$tempShared/required/clipboard/." "$HOME/clipboard/"
cp -a "$tempShared/required/Tasks/." "/c/Tasks/"
cp -a "$tempShared/required/vscodevim/." "/c/vscodevim/"

# download vundle if it does not exist
vunDir="$HOME/.vim/bundle/Vundle.vim"
[[ -d $vunDir ]] || {
  cd "$HOME/.vim/bundle"
  git clone https://github.com/VundleVim/Vundle.vim.git "$vunDir"
  cd "$HOME"
}

rm -r "$temp/"

unset tempShared
unset tempThis
unset temp

