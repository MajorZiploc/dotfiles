#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# root of the os style configs being downloaded
setupRoot="$SCRIPTPATH/.."

flags="$1"
[[ -z "$flags" ]] && { flags='00'; }

$SCRIPTPATH/../../../shared/scripts/copy.sh "$setupRoot" "$flags"

{ printf "setopt aliases\n\n"; cat ~/.bashrc.d/portable/aliases.bash; } > ~/vimfiles/bash_env.zsh;

unset setupRoot

