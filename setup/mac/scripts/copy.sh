#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$SCRIPTPATH/.."

$SCRIPTPATH/../../../shared/scripts/copy.sh "$setupRoot" "01"

unset setupRoot

