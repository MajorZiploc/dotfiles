#!/usr/bin/env bash

_p_repo="$1";
_p_replacement_patterns="$2";
_p_exclude_from_boundary_free_replacement_patterns="$3";

[[ -e "$_p_replacement_patterns" ]] && { _p_replacement_patterns="`cat "$_p_replacement_patterns"`"; }
[[ -e "$_p_exclude_from_boundary_free_replacement_patterns" ]] && { _p_exclude_from_boundary_free_replacement_patterns="`cat "$_p_exclude_from_boundary_free_replacement_patterns"`"; }
_p_exclude_from_boundary_free_replacement_patterns="`echo "$_p_exclude_from_boundary_free_replacement_patterns" | tr "\n" " "`";

cd "$1";

function replacer {
  local search_pattern="$1";
  local replace_pattern="$2";
  local extra_sed_flags="$3";
  local exclude_from_boundary_free_replace_patterns="$4";
  echo "$search_pattern -> $replace_pattern";
  echo "";
  gfind_in_files_replace "s,\b${search_pattern}\b,$replace_pattern,g$extra_sed_flags"
  for num in `seq 1 11`; do gfind_items_rename ".*$search_pattern.*" "s,\b${search_pattern}\b,$replace_pattern,g$extra_sed_flags" $num; done;
  [[ ! $exclude_from_boundary_free_replace_patterns =~ $search_pattern ]] && {
    echo "Performing nonboundary replace for $search_pattern since it was not found in the exclude list $exclude_from_boundary_free_replace_patterns";
    gfind_in_files_replace "s,${search_pattern},$replace_pattern,g$extra_sed_flags";
    for num in `seq 1 11`; do gfind_items_rename ".*$search_pattern.*" "s,${search_pattern},$replace_pattern,g$extra_sed_flags" $num; done;
  }
}

function main {
  . ~/.bashrc;
  local replaces="$1";
  local exclude_from_boundary_free_replacement_patterns="$2";
  replaces=(`echo "${replaces}" | tr "\n" " " | xargs`);

  for replace in ${replaces[@]}; do
    local search_pattern="`echo "$replace" | sed -E 's,(.*)~(.*),\1,'`";
    local replace_pattern="`echo "$replace" | sed -E 's,(.*)~(.*),\2,'`";

    echo "exact casing patterns";
    replacer "$search_pattern" "$replace_pattern" "" "$exclude_from_boundary_free_replacement_patterns"

    # prep
    local search_pattern="`echo "$search_pattern" | tr 'A-Z' 'a-z'`";
    local replace_pattern="`echo "$replace_pattern" | tr 'A-Z' 'a-z'`";

    search_pattern="echo "$search_pattern" | `to_title_case`";
    replace_pattern="echo "$replace_pattern" | `to_title_case`";
    echo "title case patterns";
    replacer "$search_pattern" "$replace_pattern" "" "$exclude_from_boundary_free_replacement_patterns"

    search_pattern="`echo "$search_pattern" | tr 'a-z' 'A-Z'`";
    replace_pattern="`echo "$replace_pattern" | tr 'a-z' 'A-Z'`";
    echo "upper patterns";
    replacer "$search_pattern" "$replace_pattern" "" "$exclude_from_boundary_free_replacement_patterns"

    search_pattern="`echo "$search_pattern" | tr 'A-Z' 'a-z'`";
    replace_pattern="`echo "$replace_pattern" | tr 'A-Z' 'a-z'`";
    echo "lower patterns";
    replacer "$search_pattern" "$replace_pattern" "" "$exclude_from_boundary_free_replacement_patterns"

  done;

  # catch all ignore case
  for replace in ${replaces[@]}; do
    local search_pattern="`echo "$replace" | sed -E 's,(.*)~(.*),\1,' | tr 'A-Z' 'a-z'`";
    local replace_pattern="`echo "$replace" | sed -E 's,(.*)~(.*),\2,' | tr 'A-Z' 'a-z'`";
    echo "ignore case patterns";
    replacer "$search_pattern" "$replace_pattern" "i" "$exclude_from_boundary_free_replacement_patterns"
  done;

}

main "$_p_replacement_patterns" "$_p_exclude_from_boundary_free_replacement_patterns";
