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

$tempShared/copy_scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "append"
$tempShared/copy_scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "prepend"
$tempShared/copy_scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "override"

# Replace occurrences of bash.exe with bash in shared content
find "$tempShared" -type f -exec sed -i.bak 's/bash\.exe/bash/g' {} \;
find "$tempShared" -regextype egrep -iregex '.*\.bak$' -type f -exec rm {} \;
find "$tempShared" -regextype egrep -iregex '.*\.json$' -type f -exec sed -i.bak 's/C:\\\\Program Files\\\\Git\\\\bin\\\\bash/\/bin\/bash/g' {} \;
find "$tempShared" -regextype egrep -iregex '.*\.bak$' -type f -exec rm {} \;

cp -a "$tempShared/required/home/." ~/
cp -a "$tempShared/required/home_bin/." ~/bin/
cp -a "$tempShared/required/clipboard/." ~/clipboard/
cp -a "$tempShared/required/Tasks/." ~/Tasks/
cp -a "$tempShared/required/vscodevim/." ~/vscodevim/

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
rm -r "$temp/"

unset tempShared
unset tempThis

