#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cp -a "$SCRIPTPATH/copy_content_to_home/." ~/

cp -a "$SCRIPTPATH/usr_local_bin/." /usr/local/bin/

cp -a "$SCRIPTPATH/Tasks/." /c/Tasks/
