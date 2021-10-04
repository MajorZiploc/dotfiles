#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"

flags="$2"

temp="$setupRoot/../temp"
tempShared="$temp/shared"
tempThis="$temp/this"

$SCRIPTPATH/create_temps.sh "$setupRoot" "$temp" "$tempShared" "$tempThis"

# call os specific substition flow script
test -f "$setupRoot/scripts/substition.sh" && { $setupRoot/scripts/substition.sh "$setupRoot" "$temp" "$tempShared" "$tempThis"; }

$tempShared/scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "append"
$tempShared/scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "prepend"
$tempShared/scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "override"
$tempShared/scripts/edit_files.sh "$temp" "$tempShared" "$tempThis" "new"

$tempShared/scripts/ensure_client_paths.sh "$setupRoot" "$temp" "$tempShared" "$tempThis" "$flags"

$tempShared/scripts/copy_content_to_client.sh "$setupRoot" "$temp" "$tempShared" "$tempThis" "$flags"

rm -r "$temp/"

unset tempShared
unset tempThis
unset temp
unset setupRoot
unset flags

