#!/usr/bin/env bash

_p_repo="$1";
_p_replacement_patterns="$2";

[[ -e "$_p_replacement_patterns" ]] && { _p_replacement_patterns="`cat "$_p_replacement_patterns"`"; }

cd "$1";

function main {
  . ~/.bashrc;
  local checks="$1";
  checks=(`echo "${checks}" | tr "\n" " " | xargs`);

  for check in ${checks[@]}; do

    local search_pattern="`echo "$check" | sed -E 's,(.*)~(.*),\1,' | tr 'A-Z' 'a-z'`";
    local replace_pattern="`echo "$check" | sed -E 's,(.*)~(.*),\2,' | tr 'A-Z' 'a-z'`";
    echo "Checking for $search_pattern";
    echo "";
    gfind_in_files "${search_pattern}"
    gfind_items ".*$search_pattern.*";

  done;

}

main "$_p_replacement_patterns";
