#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$1"
temp="$2"
tempShared="$3"
tempThis="$4"

mkdir -p "$tempShared/"
cp -r "$SCRIPTPATH/../../shared/" "$temp/"
mkdir -p "$tempThis/"
cp -r "$setupRoot" "$tempThis/"

unset setupRoot
unset tempShared
unset tempThis
unset temp

