#!/usr/bin/env bash

script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

# root of the os style configs being downloaded
setup_root="$1";
temp="$2";
temp_shared="$3";
temp_this="$4";

mkdir -p "$temp_shared/";
cp -r "$script_path/../../shared/" "$temp/";
mkdir -p "$temp_this/";
cp -r "$setup_root" "$temp_this/";

unset setup_root;
unset temp_shared;
unset temp_this;
unset temp;

