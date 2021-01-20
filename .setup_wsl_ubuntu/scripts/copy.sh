#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cp -a "$SCRIPTPATH/../copy_content_to_home/." ~/
ls -A ~ | xargs dos2unix

sudo cp -a "$SCRIPTPATH/../usr_local_bin/." /usr/local/bin/
sudo ls -A /usr/local/bin | xargs sudo dos2unix
