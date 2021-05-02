#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"
temp="$2"
tempShared="$3"
tempThis="$4"

find "$tempShared" -regextype egrep -iregex '.*bash_functions.*' -type f -exec sed -E -i'' 's,(local project_root_path=)"~/projects/home-settings",\1"/c/projects/home-settings",' {} \;
find "$tempShared" -regextype egrep -iregex ".*settings.json$" -type f -exec sed -E -i'' "s,\$HOME(\\\\_vsvimrc),/$HOME\1,g" {} \;

unset setupRoot
unset tempShared
unset tempThis
unset temp

