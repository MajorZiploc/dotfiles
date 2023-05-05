function cmd_wrap {
  local cmd="$1";
  # from std out redirect with pipe
  input=$(cat)
  eval "$cmd $input";
}

function col_n {
  # Extract the nths column from a tabular output
  # $1: pos num
  local n="$1";
  [[ -z "$n" ]] && { echo "Must specify n\!" >&2; return 1; }
  awk -v col=$n '{print $col}';
}

function skip_n {
  # Skip first n words in line
  # $1: pos num
  local n=$(($1 + 1));
  [[ -z "$n" ]] && { echo "Must specify n\!" >&2; return 1; }
  cut -d' ' -f$n-;
}

function take_n {
  # Keep first n words in line
  # $1: pos num
  local n="$1";
  [[ -z "$n" ]] && { echo "Must specify n\!" >&2; return 1; }
  cut -d' ' -f1-$n;
}

function show_block {
  # $1: regex string
  # $2: regex string
  # $3: file | symlink to file | string
  local from_pattern="$1";
  local to_pattern="$2";
  local content="$3";
  local should_print="false";
  [[ -z "$from_pattern" ]] && { echo "Must specify from_pattern" >&2; return 1; }
  [[ -z "$to_pattern" ]] && { echo "Must specify to_pattern" >&2; return 1; }
  [[ -z "$content" ]] && { echo "Must specify content" >&2; return 1; }
  [[ -e "$content" ]] && { content=$(cat "$content"); }
  echo "$content" | while IFS="" read -r p || [ -n "$p" ]; do
    if [[ "$should_print" == "true" ]]
    then
      echo "$p";
      [[ "$p" =~ $to_pattern ]] && { break; }
    else
      [[ "$p" =~ $from_pattern ]] && { echo "$p"; should_print="true"; }
    fi
  done;
}

function show_block_line_num_range {
  local start_n="$1";
  local end_n="$2";
  local content="$3";
  [[ -z "$start_n" ]] && { echo "Must specify start_n" >&2; return 1; }
  [[ -z "$end_n" ]] && { echo "Must specify end_n" >&2; return 1; }
  [[ -z "$content" ]] && { echo "Must specify content" >&2; return 1; }
  [[ -e "$content" ]] && { content=$(cat "$content"); }
  echo "$content" | perl -nle "print if $. >= $start_n and $. <= $end_n";
}

function show_line_nums {
  local content="$1";
  [[ -z "$content" ]] && { echo "Must specify content\!" >&2; return 1; }
  perl -nle 'print "$. $_"' "$content";
}

function show_cheat_sheet {
  local query="$1";
  local tool="$2";
  [[ -n "$tool" ]];
  local tool_was_param="$?";
  if [[ -z "$tool" ]]; then
    tool=$(cat "$HOME/.cheat_sheet/languages" "$HOME/.cheat_sheet/command" "$HOME/.cheat_sheet/languages-ext" "$HOME/.cheat_sheet/command-ext" 2>/dev/null | grep -Ev "^\s*$" | FUZZY_FINDER_PLACEHOLDER);
    true;
  else
    if [[ ! "$tool" =~ ~$ && ! "$tool" =~ /$ ]]; then
      echo "if tool is specified, you must end it with the character / (for language) or ~ (for command)" >&2;
      return 1;
    fi
  fi
  if [[ -z "$tool" ]]; then
    return 1;
  fi
  if [[ -z "$query" ]]; then
    tool=${tool/%\~$/};
    tool=${tool/%\/$/};
    curl "cht.sh/$tool/";
  else
    query=$(echo "$query" | tr ' ' '+');
    [[ ! "$tool_was_param" == "0" ]] && {
      if cat "$HOME/.cheat_sheet/languages" "$HOME/.cheat_sheet/languages-ext" 2>/dev/null | grep -xq "$tool"; then
        tool="$tool/";
      else
        tool="$tool~";
      fi
    }
    curl "cht.sh/$tool/$query";
  fi
}

function refactor_rename_symbols {
  local symbol_declare="$1";
  local rename_pattern="$2";
  [[ -z "$symbol_declare" ]] && { echo "Must specify symbol_declare\!" >&2; return 1; }
  [[ -z "$rename_pattern" ]] && { echo "Must specify rename_pattern\!" >&2; return 1; }
  local search_results; search_results=$(gfind_in_files "^\s*$symbol_declare\b([a-zA-Z0-9_\-]+)\b");
  local symbol_names; symbol_names=($(echo "$search_results" | sed -E "s,.*?[[:digit:]]+:.*?$symbol_declare\b([a-zA-Z0-9_\-]+)\b(.*),\1,g" | sort -u | xargs));
  [[ "$symbol_names" =~ "^[[:blank:]]*$" ]] && { echo "No symbol_names found to rename!" >&2; return 1; }
  local files; files=($(gfind_files ".*" | xargs));
  for symbol_name in ${symbol_names[@]}; do
   new_symbol_name=$(echo "$symbol_name" | sed -E "$rename_pattern");
   echo "$symbol_name -> $new_symbol_name";
    for _file in ${files[@]}; do
     sed -E -i'' "s,\b${symbol_name}\b,$new_symbol_name,g" "$_file";
    done;
  done;
}
