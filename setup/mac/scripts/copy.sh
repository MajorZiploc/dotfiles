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

mkdir -p "$HOME/.vim/bundle"
mkdir -p "$HOME/.vim/swap"
mkdir -p "$HOME/vimfiles/plugin-settings"
mkdir -p "$HOME/clipboard"
mkdir -p "$HOME/bin"
mkdir -p "$HOME/Tasks"
mkdir -p "$HOME/vscodevim"

# shared file content substitution - needs to come before append, prepend, and override
# Replace occurrences of bash.exe with bash in shared content
find "$tempShared" -type f -exec sed -i.bak 's/bash\.exe/bash/g' {} \;
find "$tempShared" -regextype egrep -iregex '.*\.bak$' -type f -exec rm {} \;
find "$tempShared" -regextype egrep -iregex '.*\.json$' -type f -exec sed -i.bak 's/C:\\\\Program Files\\\\Git\\\\bin\\\\bash/\/bin\/bash/g' {} \;
find "$tempShared" -regextype egrep -iregex '.*\.bak$' -type f -exec rm {} \;
find "$tempShared" -regextype egrep -iregex '.*bash_aliases.*' -type f -exec sed -i.bak 's/(alias refresh_settings=)"/c/projects/home-settings/setup/windows/scripts/copy.sh(.*)/\1"~/projects/home-settings/setup/windows/scripts/copy.sh\2/' {} \;

find "$tempShared" -regextype egrep -iregex '.*\.bak$' -type f -exec rm {} \;

$tempShared/scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "append"
$tempShared/scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "prepend"
$tempShared/scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "override"

cp -a "$tempShared/required/home/." "$HOME/"
cp -a "$tempShared/required/home_bin/." "$HOME/bin/"
cp -a "$tempShared/required/clipboard/." "$HOME/clipboard/"
cp -a "$tempShared/required/Tasks/." "$HOME/Tasks/"
cp -a "$tempShared/required/vscodevim/." "$HOME/vscodevim/"


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

