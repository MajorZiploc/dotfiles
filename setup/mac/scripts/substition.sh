#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"
temp="$2"
tempShared="$3"
tempThis="$4"

find "$tempShared/" -type f -exec dos2unix {} \;
find "$tempThis/" -type f -exec dos2unix {} \;

find "$tempShared" -regextype egrep -iregex ".*" -type f -exec sed -i'' 's/VIM_PLUGIN_IMPORT_PLACEHOLDER/so ~\/_vim_plugins/g' {} \;
find "$tempShared" -regextype egrep -iregex ".*" -type f -exec sed -i'' 's/VSC_INTEGRATED_SHELL_PLACEHOLDER/\/bin\/bash/g' {} \;
vsvimpath="$(echo "$HOME/vscodevim/_vsvimrc")"
find "$tempShared" -regextype egrep -iregex ".*" -type f -exec sed -E -i'' "s,VSVIM_DIR_PLACEHOLDER,$vsvimpath,g" {} \;
find "$tempShared" -regextype egrep -iregex ".*" -type f -exec sed -E -i'' "s,OS_PLACE_HOLDER,mac,g" {} \;
find "$tempShared" -regextype egrep -iregex ".*" -type f -exec sed -i'' 's,VIM_SHELL_PLACEHOLDER,/bin/bash,g' {} \;
# example of deleting bak files
# find "$tempShared" -regextype egrep -iregex '.*\.bak$' -type f -exec rm {} \;

unset setupRoot
unset tempShared
unset tempThis
unset temp

