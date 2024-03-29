#!/usr/bin/env bash

script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

# root of the os style configs being downloaded
setup_root="$script_path/..";

flags="$1";
[[ -z "$flags" ]] && { flags='00'; }

"$script_path/../../../shared/scripts/copy.sh" "$setup_root" "$flags";

unset setup_root;

