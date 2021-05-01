#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"
temp="$2"
tempShared="$3"
tempThis="$4"

find "$tempShared/" -type f -exec dos2unix {} \;
find "$tempThis/" -type f -exec dos2unix {} \;

# shared file content substitution - needs to come before append, prepend, and override
# Replace occurrences of bash.exe with bash in shared content
find "$tempShared" -type f -exec sed -i'' 's/bash\.exe/bash/g' {} \;
find "$tempShared" -regextype egrep -iregex '.*\.json$' -type f -exec sed -i'' 's/C:\\\\Program Files\\\\Git\\\\bin\\\\bash/\/bin\/bash/g' {} \;
find "$tempShared" -regextype egrep -iregex '.*\.vimrc$' -type f -exec sed -i'' 's/so ~\/_vim_plugins/" so ~\/_vim_plugins/g' {} \;
find "$tempShared" -regextype egrep -iregex '.*bash_functions.*' -type f -exec sed -E -i'' 's,(local project_root_path=)"/c/projects/home-settings",\1"~/projects/home-settings",' {} \;

unset setupRoot
unset tempShared
unset tempThis
unset temp

