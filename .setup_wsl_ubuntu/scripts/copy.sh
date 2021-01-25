#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cd ~
cp -a "$SCRIPTPATH/../copy_content_to_home/." .
ls -A | xargs dos2unix

cd /usr/local/bin
sudo cp -a "$SCRIPTPATH/../usr_local_bin/." .
sudo ls -A | xargs sudo dos2unix
