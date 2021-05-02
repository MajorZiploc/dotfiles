#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"
temp="$2"
tempShared="$3"
tempThis="$4"

find "$tempShared/" -type f -exec dos2unix {} \;
find "$tempThis/" -type f -exec dos2unix {} \;

find "$tempShared" -type f -exec sed -i'' 's/bash\.exe/bash/g' {} \;
find "$tempShared" -regextype egrep -iregex '.*settings.json' -type f -exec sed -i'' 's/VS_INTEGRATED_SHELL_PLACEHOLDER/\/bin\/bash/' {} \;
find "$tempShared" -regextype egrep -iregex '.*\.vimrc$' -type f -exec sed -i'' 's/so ~\/_vim_plugins/" so ~\/_vim_plugins/g' {} \;
vsvimpath="$(echo "$HOME/vscodevim/_vsvimrc")"
find "$tempShared" -regextype egrep -iregex ".*settings.json" -type f -exec sed -E -i'' "s,VSVIM_DIR_PLACEHOLDER,$vsvimpath," {} \;
find "$tempShared" -regextype egrep -iregex ".*bash_functions.*" -type f -exec sed -E -i'' "s,OS_PLACE_HOLDER,wsl_ubuntu," {} \;
find "$tempShared" -regextype egrep -iregex ".*" -type f -exec sed -i'' 's,VIM_SHELL_PLACEHOLDER,/bin/bash,' {} \;

unset setupRoot
unset tempShared
unset tempThis
unset temp

