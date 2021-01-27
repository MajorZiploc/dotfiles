#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swap

cp -a "$SCRIPTPATH/../copy_content_to_home/." ~/

cp -a "$SCRIPTPATH/../.ahk" ~/

cp -a "$SCRIPTPATH/../clipboard" ~/

cp -a "$SCRIPTPATH/../usr_local_bin/." /usr/local/bin/

cp -a "$SCRIPTPATH/../Tasks/." /c/Tasks/

cp -a "$SCRIPTPATH/../vscodevim/." /c/vscodevim/
