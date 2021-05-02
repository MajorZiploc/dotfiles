#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"
temp="$2"
tempShared="$3"
tempThis="$4"

vsvimpath="$(echo "$HOME/vscodevim/_vsvimrc" | sed 's,^/c,c:,g' | sed -E 's,/,\\\\\\\\,g')"
find "$tempShared" -regextype egrep -iregex ".*settings.json" -type f -exec sed -E -i'' "s,VSVIM_DIR_PLACEHOLDER,$vsvimpath," {} \;
find "$tempShared" -regextype egrep -iregex ".*bash_functions.*" -type f -exec sed -E -i'' "s,OS_PLACE_HOLDER,windows," {} \;

unset setupRoot
unset tempShared
unset tempThis
unset temp

