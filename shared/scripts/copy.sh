#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"

temp="$setupRoot/../temp"
tempShared="$temp/shared"
tempThis="$temp/this"

mkdir -p "$tempShared/"
cp -r "$SCRIPTPATH/../../shared/" "$temp/"
mkdir -p "$tempThis/"
cp -r "$setupRoot" "$tempThis/"

# call os specific substition flow script
$tempThis/scripts/substition.sh "$temp" "$tempShared" "$tempThis"

$tempShared/scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "append"
$tempShared/scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "prepend"
$tempShared/scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "override"

mkdir -p "$HOME/.vim/bundle"
mkdir -p "$HOME/.vim/swap"
mkdir -p "$HOME/vimfiles/plugin-settings"
mkdir -p "$HOME/clipboard"
mkdir -p "$HOME/bin"
mkdir -p "/c/Tasks"
mkdir -p "/c/vscodevim"

test -f "$tempThis/.ahk" && { cp -a "$tempThis/.ahk" "$HOME/"; }

cp -a "$tempShared/required/home/." "$HOME/"
cp -a "$tempShared/required/home_bin/." "$HOME/bin/"
cp -a "$tempShared/required/clipboard/." "$HOME/clipboard/"
cp -a "$tempShared/required/Tasks/." "/c/Tasks/"
cp -a "$tempShared/required/vscodevim/." "/c/vscodevim/"
cp -a "$tempShared/required/AppData/Roaming/Code/User/." "$HOME/AppData/Roaming/Code/User/"

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

