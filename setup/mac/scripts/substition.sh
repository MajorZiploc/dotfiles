#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"
temp="$2"
tempShared="$3"
tempThis="$4"

find "$tempShared/" -type f -exec dos2unix {} \;
find "$tempThis/" -type f -exec dos2unix {} \;

# example of deleting bak files
# find "$tempShared" -regextype egrep -iregex '.*\.bak$' -type f -exec rm {} \;
find "$tempShared" -regextype egrep -iregex '.*settings.json' -type f -exec sed -i'' 's/VS_INTEGRATED_SHELL_PLACEHOLDER/\/bin\/bash/' {} \;
vsvimpath="$(echo "$HOME/vscodevim/_vsvimrc")"
find "$tempShared" -regextype egrep -iregex ".*settings.json" -type f -exec sed -E -i'' "s,VSVIM_DIR_PLACEHOLDER,$vsvimpath," {} \;
find "$tempShared" -regextype egrep -iregex ".*bash_functions.*" -type f -exec sed -E -i'' "s,OS_PLACE_HOLDER,mac," {} \;
find "$tempShared" -regextype egrep -iregex ".*" -type f -exec sed -i'' 's,VIM_SHELL_PLACEHOLDER,/bin/bash,' {} \;

unset setupRoot
unset tempShared
unset tempThis
unset temp

