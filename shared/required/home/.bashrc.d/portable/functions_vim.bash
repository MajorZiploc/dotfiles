function cmd_wrap {
  local cmd="$1";
  # $(cat) input from std out redirect with pipe
  eval "$cmd" $(cat);
}

function col_n {
  # Extract the nths column from a tabular output
  # $1: pos num
  local n="$1";
  [[ -z "$n" ]] && { echo "Must specify n" >&2; return 1; }
  awk -v col=$n '{print $col}';
}

function skip_n {
  # Skip first n words in line
  # $1: pos num
  local n=$(($1 + 1));
  [[ -z "$n" ]] && { echo "Must specify n" >&2; return 1; }
  cut -d' ' -f$n-;
}

function take_n {
  # Keep first n words in line
  # $1: pos num
  local n="$1";
  [[ -z "$n" ]] && { echo "Must specify n" >&2; return 1; }
  cut -d' ' -f1-$n;
}

function show_block {
  # $1: regex string
  # $2: regex string
  # $3: file | symlink to file | string
  local from_pattern="$1";
  local to_pattern="$2";
  local content="$3";
  local should_append="false";
  local filename;
  [[ -z "$from_pattern" ]] && { echo "Must specify from_pattern" >&2; return 1; }
  [[ -z "$to_pattern" ]] && { echo "Must specify to_pattern" >&2; return 1; }
  [[ -z "$content" ]] && { echo "Must specify content" >&2; return 1; }
  [[ -e "$content" ]] && { filename="$content"; content=$(cat "$content"); }
  local block="";
  local starting_line;
  local ending_line;
  local current_line=1;
  while IFS="" read -r p || [ -n "$p" ]; do
    if [[ "$should_append" == "true" ]]; then
      block="${block}
${p}";
      [[ "$p" =~ $to_pattern ]] && { ending_line="$current_line"; break; }
    else
      [[ "$p" =~ $from_pattern ]] && { starting_line="$current_line"; block="$p"; should_append="true"; }
    fi
    current_line=$((current_line + 1));
  done < <(echo "$content");
  if [[ -n "$starting_line" && -n "$ending_line" ]]; then
    [[ -n "$filename" ]] && { echo "$filename"; }
    echo ":$starting_line:$ending_line:";
    echo "$block";
  fi
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
  [[ -z "$content" ]] && { echo "Must specify content" >&2; return 1; }
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
    curl -s "cht.sh/$tool/";
  else
    query=$(echo "$query" | tr ' ' '+');
    [[ ! "$tool_was_param" == "0" ]] && {
      if cat "$HOME/.cheat_sheet/languages" "$HOME/.cheat_sheet/languages-ext" 2>/dev/null | grep -xq "$tool"; then
        tool="$tool/";
      else
        tool="$tool~";
      fi
    }
    curl -s "cht.sh/$tool/$query";
  fi
}

function refactor_rename_symbols {
  local rename_pattern="$1";
  local file_pattern=$2; file_pattern="${file_pattern:-".*"}"
  local symbol_declare_prefix="$3"; symbol_declare_prefix="${symbol_declare_prefix:-""}";
  local symbol_declare_postfix="$4"; symbol_declare_postfix="${symbol_declare_postfix:-""}";
  [[ -z "$rename_pattern" ]] && { echo "Must specify rename_pattern" >&2; return 1; }
  local search_results; search_results=$(gfind_in_files "^\s*$symbol_declare_prefix\b([a-zA-Z0-9_\-]+)\b$symbol_declare_postfix" "$file_pattern");
  local symbol_names; symbol_names=($(echo "$search_results" | sed -E "s,.*?[[:digit:]]+:.*?$symbol_declare_prefix\b([a-zA-Z0-9_\-]+)\b$symbol_declare_postfix(.*),\1,g" | sort -u | xargs));
  [[ "$symbol_names" =~ "^[[:blank:]]*$" ]] && { echo "No symbol_names found to rename" >&2; return 1; }
  local files; files=($(gfind_files "$file_pattern" | xargs));
  for symbol_name in ${symbol_names[@]}; do
   new_symbol_name=$(echo "$symbol_name" | sed -E "$rename_pattern");
   echo "$symbol_name -> $new_symbol_name";
    for _file in ${files[@]}; do
     sed -E -i'' "s,\b${symbol_name}\b,$new_symbol_name,g" "$_file";
    done;
  done;
}

function _find_generate_not_paths {
  local not_paths="";
  for gitignore_entry in $@; do
    not_paths="$not_paths -not -path '*/$gitignore_entry/*'";
  done;
  echo "$not_paths";
}

function _find_default_ignored_dirs {
  _find_generate_not_paths "${FIND_DEFAULT_IGNORE_DIRS[@]}";
}

function _find_git_estimator_children_git_ignores {
  local search_depth_for_nested_git_ignores=$1;
  search_depth_for_nested_git_ignores="${search_depth_for_nested_git_ignores:="$FIND_GIT_DEFAULT_CHILD_GITIGNORE_SEARCH_DEPTH"}";
  local git_ignore_content="";
  [[ $search_depth_for_nested_git_ignores -ge 2 ]] && {
    while read -r -d $'\0' _git_ignore; do
      git_ignore_content+="$({ sort -u "$_git_ignore" | trim | grep -Ev "('|\"|;|#|\\!|,|\\{|\\}|\\@|\\||\\^|\\(|\\)|^[[:blank:]]*$|\\&|\\$|\\\\|~|\\+|\`|=|[^[:blank:]]+\.[^[:blank:]]{1,6}\$)" | tr " " "\n" | sed -E 's,^[/\*]*/,,g;s,/[/\*]*$,,g;' | sed -E "s,(.*),$(dirname "$_git_ignore")/*/\\1,"; printf "\n"; } )";
    done < <(find . -mindepth "2" -maxdepth "$search_depth_for_nested_git_ignores" -name ".gitignore" -print0);
  }
  local gitignore_entries;
  gitignore_entries=($(echo "$git_ignore_content" | xargs));
  local not_paths="";
  for gitignore_entry in ${gitignore_entries[@]}; do
    not_paths="$not_paths -not -path '$gitignore_entry/*'";
  done;
  echo "$not_paths";
}

function find_show_exec_search_block {
  local from_pattern="$1";
  local to_pattern="$2";
  [[ -z "$from_pattern" ]] && { echo "Must specify from_pattern" >&2; return 1; }
  [[ -z "$to_pattern" ]] && { echo "Must specify to_pattern" >&2; return 1; }
  echo "-exec bash -c 'source ~/.bashrc.d/portable/functions_vim.bash; show_block \"$from_pattern\" \"$to_pattern\" \"{}\" | head -n 3 | tr -d \"\n\"; echo \"\";' \;";
}

function _find_git_estimator_ignored_dirs_root {
  local get_ancestor_git_ignore_content; get_ancestor_git_ignore_content="$(
    git_ignore_content="$(cat .gitignore 2>/dev/null)";
    current_path="$(pwd)";
    while [[ ! "$current_path" == "/" ]] ; do
      [[ -d .git ]] && {
        break;
      }
      cd ..;
      current_path="$(pwd)";
      git_ignore_content+="$(printf "\n ")";
      git_ignore_content+="$(cat .gitignore 2>/dev/null)";
      git_ignore_content+="$(printf "\n ")";
    done;
     echo "$git_ignore_content";
  )";
  local git_ignore_content gitignore_entries;
  git_ignore_content=$({ echo "$get_ancestor_git_ignore_content"; echo ".git .svn"; });
  gitignore_entries=($(echo "$git_ignore_content" | sort -u | trim | grep -Ev "('|\"|;|#|\\!|,|\\{|\\}|\\@|\\||\\^|\\(|\\)|^[[:blank:]]*$|\\&|\\$|\\\\|~|\\+|\`|=|[^[:blank:]]+\.[^[:blank:]]{1,6}\$)" | tr " " "\n" | sed -E 's,^[/\*]*/,,g;s,/[/\*]*$,,g;' | xargs));
  gitignore_entries+=($(echo "${FIND_GIT_EXTRA_IGNORE_DIRS[@]}"));
  gitignore_entries=($(echo "${gitignore_entries[@]}" | tr ' ' '\n' | sort -u | xargs));
  _find_generate_not_paths "${gitignore_entries[@]}";
}

function _find_git_estimator_ignored_dirs {
  local not_paths="";
  not_paths+="$(_find_git_estimator_ignored_dirs_root)";
  local child_not_paths=""; child_not_paths="$(_find_git_estimator_children_git_ignores "$1")";
  if [[ -n "$child_not_paths" ]]; then
    child_not_paths=${child_not_paths+" $child_not_paths"};
    not_paths="${not_paths}${child_not_paths}";
  fi
  echo "$not_paths";
}

function _find_items_rename_helper {
  local file_pattern="$1";
  [[ -z "$file_pattern" ]] && { echo "Must specify a file pattern" >&2; return 1; }
  local by="$2";
  [[ -z "$by" ]] && { echo "Must specify a by substitution" >&2; return 1; }
  local preview=$3;
  [[ -z "$preview" ]] && { echo "Must specify the preview flag" >&2; return 1; }
  local maxdepth="$4";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths="$5";
  local new_name;
  local _cmd;
  for mdepth in $(seq 1 "$maxdepth"); do
    _cmd="find . -mindepth '$mdepth' -maxdepth '$mdepth' -regextype egrep -iregex '$file_pattern' $not_paths -print0";
    if [[ "$FIND_SHOULD_SHOW_COMMAND" == "true" ]]; then
      echo "$_cmd"
    else
     while read -r -d $'\0' item; do
      unset new_name; new_name="$(echo "$item" | sed -E "$by")";
      [[ "$item" != "$new_name" ]] && {
        if [[ $preview == false ]]; then
          mv "$item" "$new_name";
        else
          echo "mv" "'$item'" "'$new_name'" ";";
        fi
      }
      done < <(eval "$_cmd");
    fi
  done;
}

function find_items_rename_preview {
  local not_paths; not_paths="$(_find_default_ignored_dirs)";
  _preview_warning_message;
  _find_items_rename_helper "$1" "$2" true "$3" "$not_paths";
}

function afind_items_rename_preview {
  local not_paths="";
  _preview_warning_message;
  _find_items_rename_helper "$1" "$2" true "$3" "$not_paths";
}

function gfind_items_rename_preview {
  local not_paths; not_paths="$(_find_git_estimator_ignored_dirs "$4")";
  _preview_warning_message;
  _find_items_rename_helper "$1" "$2" true "$3" "$not_paths";
}

function find_items_rename {
  local not_paths; not_paths="$(_find_default_ignored_dirs)";
  _find_items_rename_helper "$1" "$2" false "$3" "$not_paths";
}

function afind_items_rename {
  local not_paths="";
  _find_items_rename_helper "$1" "$2" false "$3" "$not_paths";
}

function gfind_items_rename {
  local not_paths; not_paths="$(_find_git_estimator_ignored_dirs "$4")";
  _find_items_rename_helper "$1" "$2" false "$3" "$not_paths";
}

function _find_items_delete_helper {
  local file_pattern="$1";
  [[ -z "$file_pattern" ]] && { echo "Must specify a file pattern" >&2; return 1; }
  local preview=$2;
  [[ -z "$preview" ]] && { echo "Must specify the preview flag" >&2; return 1; }
  local maxdepth="$3";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths="$4";
  local _cmd;
  for mdepth in $(seq 1 "$maxdepth"); do
    _cmd="find . -mindepth '$mdepth' -maxdepth '$mdepth' -regextype egrep -iregex '$file_pattern' $not_paths -print0";
    if [[ "$FIND_SHOULD_SHOW_COMMAND" == "true" ]]; then
      echo "$_cmd"
    else
      while read -r -d $'\0' item; do
        if [[ $preview == false ]]; then
          rm -rf "$item";
        else
          echo "rm -rf" "'$item'" ";";
        fi
      done < <(eval "$_cmd");
    fi
  done;
}

function _preview_warning_message {
  echo "NOTE: This behavior may not be the exact behavior when running the command out of preview mode";
}

function find_items_delete_preview {
  local not_paths; not_paths="$(_find_default_ignored_dirs)";
  _preview_warning_message;
  _find_items_delete_helper "$1" true "$2" "$not_paths";
}

function afind_items_delete_preview {
  local not_paths="";
  _preview_warning_message;
  _find_items_delete_helper "$1" true "$2" "$not_paths";
}

function gfind_items_delete_preview {
  local not_paths; not_paths="$(_find_git_estimator_ignored_dirs "$3")";
  _preview_warning_message;
  _find_items_delete_helper "$1" true "$2" "$not_paths";
}

function find_items_delete {
  local not_paths; not_paths="$(_find_default_ignored_dirs)";
  _find_items_delete_helper "$1" false "$2" "$not_paths";
}

function afind_items_delete {
  local not_paths="";
  _find_items_delete_helper "$1" false "$2" "$not_paths";
}

function gfind_items_delete {
  local not_paths; not_paths="$(_find_git_estimator_ignored_dirs "$3")";
  _find_items_delete_helper "$1" false "$2" "$not_paths";
}

function _find_items_helper {
  local file_pattern="$1";
  [[ -z "$file_pattern" ]] && { echo "Must specify a file pattern" >&2; return 1; }
  local maxdepth="$2";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths="$3";
  local _cmd; _cmd="find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' $not_paths";
  if [[ "$FIND_SHOULD_SHOW_COMMAND" == "true" ]]; then
    echo "$_cmd";
  else
    eval "$_cmd";
  fi
}

function find_items {
  local not_paths; not_paths="$(_find_default_ignored_dirs)";
  _find_items_helper "$1" "$2" "$not_paths";
}

function afind_items {
  local not_paths="";
  _find_items_helper "$1" "$2" "$not_paths";
}

function gfind_items {
  local not_paths; not_paths="$(_find_git_estimator_ignored_dirs "$3")";
  _find_items_helper "$1" "$2" "$not_paths";
}

function find_items_fuzz {
  find_items "$(echo "$1" | to_fuzz)" "$2";
}

function afind_items_fuzz {
  find_items "$(echo "$1" | to_fuzz)" "$2";
}

function gfind_items_fuzz {
  find_items "$(echo "$1" | to_fuzz)" "$2";
}

function _find_files_delete_preview_helper {
  local file_pattern="$1";
  [[ -z "$file_pattern" ]] && { echo "Must specify a file pattern" >&2; return 1; }
  local with_content="$2";
  local maxdepth="$3";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths="$4";
  local _cmd="find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' -type f $not_paths";
  if [[ -z "$with_content" ]]; then
    _cmd="$_cmd -exec echo rm \"'{}' ;\" \;";
  else
    _cmd="$_cmd -exec grep -Ein -e '$with_content' \"{}\" \; -exec echo rm \"'{}' ;\" \; | grep -E \"^rm\" ;";
  fi
  if [[ "$FIND_SHOULD_SHOW_COMMAND" == "true" ]]; then
    echo "$_cmd";
  else
    eval "$_cmd";
  fi
}

function _find_files_delete_helper {
  local file_pattern="$1";
  [[ -z "$file_pattern" ]] && { echo "Must specify a file pattern" >&2; return 1; }
  local with_content="$2";
  local maxdepth="$3";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths; not_paths="$(_find_default_ignored_dirs)";
  local _cmd="find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' -type f $not_paths";
  if [[ -z "$with_content" ]]; then
    _cmd="$_cmd -exec rm \"{}\" \;";
  else
    _cmd="$_cmd -exec grep -Ein -e '$with_content' \"{}\" \; -exec rm \"{}\" \;" > /dev/null;
  fi
  if [[ "$FIND_SHOULD_SHOW_COMMAND" == "true" ]]; then
    echo "$_cmd";
  else
    eval "$_cmd";
  fi
}

function find_files_delete_preview {
  local not_paths; not_paths="$(_find_default_ignored_dirs)";
  _find_files_delete_preview_helper "$1" "$2" "$3" "$not_paths";
}

function afind_files_delete_preview {
  local not_paths="";
  _find_files_delete_preview_helper "$1" "$2" "$3" "$not_paths";
}

function gfind_files_delete_preview {
  local not_paths; not_paths="$(_find_git_estimator_ignored_dirs "$4")";
  _find_files_delete_preview_helper "$1" "$2" "$3" "$not_paths";
}

function find_files_delete {
  local not_paths; not_paths="$(_find_default_ignored_dirs)";
  _find_files_delete_helper "$1" "$2" "$3" "$not_paths";
}

function afind_files_delete {
  local not_paths="";
  _find_files_delete_helper "$1" "$2" "$3" "$not_paths";
}

function gfind_files_delete {
  local not_paths; not_paths="$(_find_git_estimator_ignored_dirs "$4")";
  _find_files_delete_helper "$1" "$2" "$3" "$not_paths";
}

function _find_files_rename_helper {
  local file_pattern="$1";
  [[ -z "$file_pattern" ]] && { echo "Must specify a file pattern" >&2; return 1; }
  local by="$2";
  [[ -z "$by" ]] && { echo "Must specify a by substitution" >&2; return 1; }
  local with_content="$3";
  local preview=$4
  [[ -z "$preview" ]] && { echo "Must specify the preview flag" >&2; return 1; }
  local maxdepth="$5";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths="$6";
  local b nb new_name should_rename;
  local _cmd; _cmd="find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' -type f $not_paths -print0";
  if [[ "$FIND_SHOULD_SHOW_COMMAND" == "true" ]]; then
    echo "$_cmd";
  else
    while read -r -d $'\0' file; do
    should_rename=false;
    if [[ -z "$with_content" ]]; then
      should_rename=true;
    else
      file_content_matches="$(grep -Ein "$with_content" "$file")"
      [[ -z "$file_content_matches" ]] || { should_rename=true; }
    fi
    [[ $should_rename == true ]] && {
      unset b; b=$(basename "$file");
      unset nb; nb="$(echo "$b" | sed -E "$by")";
      unset new_name; new_name="$(dirname "$file")/$nb"
      [[ "$file" != "$new_name" ]] && {
        if [[ $preview == false ]]; then
          mv "$file" "$new_name";
        else
          echo "mv" "'$file'" "'$new_name'" ";";
        fi
      }
    }
    done < <(eval "$_cmd");
  fi
}

function find_files_rename_preview {
  local not_paths; not_paths="$(_find_default_ignored_dirs)";
  _find_files_rename_helper "$1" "$2" "$3" true "$4" "$not_paths";
}

function afind_files_rename_preview {
  local not_paths="";
  _find_files_rename_helper "$1" "$2" "$3" true "$4" "$not_paths";
}

function gfind_files_rename_preview {
  local not_paths; not_paths="$(_find_git_estimator_ignored_dirs "$5")";
  _find_files_rename_helper "$1" "$2" "$3" true "$4" "$not_paths";
}

function find_files_rename {
  local not_paths; not_paths="$(_find_default_ignored_dirs)";
  _find_files_rename_helper "$1" "$2" "$3" false "$4" "$not_paths";
}

function afind_files_rename {
  local not_paths="";
  _find_files_rename_helper "$1" "$2" "$3" false "$4" "$not_paths";
}

function gfind_files_rename {
  local not_paths; not_paths="$(_find_git_estimator_ignored_dirs "$5")";
  _find_files_rename_helper "$1" "$2" "$3" false "$4" "$not_paths";
}

function _find_files_helper {
  local file_pattern="$1";
  [[ -z "$file_pattern" ]] && { echo "Must specify a file pattern" >&2; return 1; }
  local with_content; with_content="$(echo "$2" | sed "s,','\"'\"',g")";
  local maxdepth="$3";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths="$4";
  local _cmd;
  _cmd="find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' -type f $not_paths";
  if [[ -n "$with_content" ]]; then
    local _exec_cmd=" -exec grep -Ein -e '$with_content' \"{}\" \; -exec echo \"{}\" \; | grep -Ev \"\s*^[[:digit:]]+:\"";
    # NOTE: use \-exec to search for -exec rather than providing your own -exec command
    local _exec_pattern="^-exec .{5,}"
    if [[ "$with_content" =~ $_exec_pattern ]]; then
      local _exec_cmd="$with_content";
    fi
    _cmd="$_cmd $_exec_cmd";
  fi
  if [[ "$FIND_SHOULD_SHOW_COMMAND" == "true" ]]; then
    echo "$_cmd";
  else
    eval "$_cmd";
  fi
}

function find_files {
  local not_paths; not_paths="$(_find_default_ignored_dirs)";
  _find_files_helper "$1" "$2" "$3" "$not_paths";
}

function afind_files {
  local not_paths="";
  _find_files_helper "$1" "$2" "$3" "$not_paths";
}

function gfind_files {
  local not_paths; not_paths="$(_find_git_estimator_ignored_dirs "$4")";
  _find_files_helper "$1" "$2" "$3" "$not_paths";
}

function find_files_fuzz {
  local not_paths; not_paths="$(_find_default_ignored_dirs)";
  _find_files_helper "$(echo "$1" | to_fuzz)" "$2" "$3" "$not_paths";
}

function afind_files_fuzz {
  local not_paths="";
  _find_files_helper "$(echo "$1" | to_fuzz)" "$2" "$3" "$not_paths";
}

function gfind_files_fuzz {
  local not_paths; not_paths="$(_find_git_estimator_ignored_dirs "$4")";
  _find_files_helper "$(echo "$1" | to_fuzz)" "$2" "$3" "$not_paths";
}

function _find_in_files_helper {
  local grep_pattern; grep_pattern="$(echo -E "$1" | sed "s,','\"'\"',g")";
  [[ -z "$grep_pattern" ]] && { echo "Must specify a grep pattern" >&2; return 1; }
  local file_pattern="$2";
  [[ -z "$file_pattern" ]] && { file_pattern=".*"; }
  local maxdepth="$3";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths="$4";
  local _exec_cmd="-exec grep -E --with-filename --color -in -e '$grep_pattern' \"{}\" +;";
  # NOTE: use \-exec to search for -exec rather than providing your own -exec command
  local _exec_pattern="^-exec .{5,}"
  if [[ "$grep_pattern" =~ $_exec_pattern ]]; then
    local _exec_cmd="$grep_pattern";
  fi
  local _cmd; _cmd="find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' -type f $not_paths $_exec_cmd";
  if [[ "$FIND_SHOULD_SHOW_COMMAND" == "true" ]]; then
    echo "$_cmd";
  else
    eval "$_cmd";
  fi
}

function find_in_files {
  local not_paths; not_paths="$(_find_default_ignored_dirs)";
  _find_in_files_helper "$1" "$2" "$3" "$not_paths";
}

function afind_in_files {
  local not_paths="";
  _find_in_files_helper "$1" "$2" "$3" "$not_paths";
}

function gfind_in_files {
  local not_paths; not_paths="$(_find_git_estimator_ignored_dirs "$4")";
  _find_in_files_helper "$1" "$2" "$3" "$not_paths";
}

function find_in_files_fuzz {
  local not_paths; not_paths="$(_find_default_ignored_dirs)";
  _find_in_files_helper "$(echo "$1" | to_fuzz)" "$2" "$3" "$not_paths";
}

function afind_in_files_fuzz {
  local not_paths="";
  _find_in_files_helper "$(echo "$1" | to_fuzz)" "$2" "$3" "$not_paths";
}

function gfind_in_files_fuzz {
  local not_paths; not_paths="$(_find_git_estimator_ignored_dirs "$4")";
  _find_in_files_helper "$(echo "$1" | to_fuzz)" "$2" "$3" "$not_paths";
}

function _find_in_files_replace_helper {
  local by; by="$(echo -E "$1" | sed "s,','\"'\"',g")";
  [[ -z "$by" ]] && { echo "Must specify a by substitution" >&2; return 1; }
  local file_pattern="$2";
  [[ -z "$file_pattern" ]] && { file_pattern=".*"; }
  local maxdepth="$3";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths="$4";
  local _cmd; _cmd="find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' -type f $not_paths -exec sed -E -i'' '$by' \"{}\" \;";
  if [[ "$FIND_SHOULD_SHOW_COMMAND" == "true" ]]; then
    echo "$_cmd";
  else
    eval "$_cmd";
  fi
}

function find_in_files_replace {
  local not_paths; not_paths="$(_find_default_ignored_dirs)";
  _find_in_files_replace_helper "$1" "$2" "$3" "$not_paths";
}

function afind_in_files_replace {
  local not_paths="";
  _find_in_files_replace_helper "$1" "$2" "$3" "$not_paths";
}

function gfind_in_files_replace {
  local not_paths; not_paths="$(_find_git_estimator_ignored_dirs "$4")";
  _find_in_files_replace_helper "$1" "$2" "$3" "$not_paths";
}

# NOTE: uuidgen does exist on many unix based systems. This is a back up if uuidgen doesnt exist
function uuid_gen {
  python -c "
import uuid
print(uuid.uuid4())
";
}
