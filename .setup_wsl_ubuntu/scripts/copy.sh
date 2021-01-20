#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cp -a "$SCRIPTPATH/../copy_content_to_home/." ~/
la ~ | xargs dos2unix

cp -a "$SCRIPTPATH/../usr_local_bin/." /usr/local/bin/
la ~ | xargs /usr/local/bin/
