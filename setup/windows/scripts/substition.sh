#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"
temp="$2"
tempShared="$3"
tempThis="$4"

find "$tempShared/scripts"  -maxdepth 9 -regextype egrep -iregex ".*" -type f -exec sed -Ei.bak 's,\$HOME/(Tasks|vscodevim),/c/\1,g' {} \;
find "$tempShared" -regextype egrep -iregex '.*\.bak$' -type f -exec rm {} \;

unset setupRoot
unset tempShared
unset tempThis
unset temp

