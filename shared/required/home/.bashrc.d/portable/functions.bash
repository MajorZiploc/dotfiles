function h {
  # show history
  # $1: optional pos num to show last n entries in the history
  local n="$1";
  [[ -z "$n" ]] && { n=25; }
  history | tail -n "$n";
}

function tmuxcs {
  # tmux create session
  # creates a tmux session
  # $1: optional string to represent name of the tmux session
  # If $1 not given, then use the base name of the path as the session name
  local session_name="$1";
  session_name="${session_name:-"$(basename "`pwd`")"}";
  session_name=$(echo "$session_name" | tr '.[[:blank:]]' '-');
  tmux new -s "$session_name" 2>/dev/null || tmux new -d -s "$session_name" && tmux switch-client -t "$session_name";
}

function tmuxps_get_project_dirs {
  export TMUXPS_PROJECT_DIRS=TMUXPS_PATHS_ARRAY_PLACEHOLDER;
}

function _tmux_session_list_helper {
  local session_name="$1";
  local selected="$2";
  [[ -z "$selected" ]] || {
    [[ -z "$session_name" ]] && {
      session_name=$(basename "$selected" | tr '.[[:blank:]]' '-');
    }
    if tmux switch-client -t "$session_name"; then
      exit 0;
    fi
    tmux new-session -c "$selected" -d -s "$session_name" \
      && tmux switch-client -t "$session_name"\; split-window -c "$selected" -h \; select-pane -L \; new-window -c "$selected" \; next-window \
      || tmux new -c "$selected" -A -s "$session_name"\; split-window -c "$selected" -h \; select-pane -L \; new-window -c "$selected" \; next-window;
  }
}

function tmuxps {
  # tmux project session
  # creates a tmux session
  # $1: optional session name
  local session_name="$1";
  local items="";
  tmuxps_get_project_dirs;
  for _path in $(echo "${TMUXPS_PROJECT_DIRS[@]}" | tr " " "\n"); do
    [[ -d "$_path" ]] && {
      items+=$(find "$_path" -maxdepth 1 -mindepth 1 -type d);
      items+="\n";
    }
  done;
  local selected;
  selected=$(printf "$items" | FUZZY_FINDER_PLACEHOLDER);
  _tmux_session_list_helper "$session_name" "$selected";
}

function tmuxds {
  # tmux directory session
  # displays a fuzzy finder listing of directories at the current directory to choose from for a tmux session
  # $1: optional session name
  local session_name="$1";
  local selected;
  selected=$(find . -maxdepth 1 -mindepth 1 -type d | FUZZY_FINDER_PLACEHOLDER);
  _tmux_session_list_helper "$session_name" "$selected";
}

function show_machine_details {
  local user machine_name long_info;
  user=$(whoami);
  machine_name=$(uname -n);
  long_info=$(uname -a);
  echo "user: $user";
  echo "machine_name: $machine_name";
  echo "long_info: $long_info";
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

function show_file_content {
  # displays file contents lead by the name of the file
  # files=$@
  echo "Files: $@";
  echo "";
  tail -n +1 $@;
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

function refresh_settings_help {
local docs=`cat << EOF
Purpose:
Refresh your bash, vim, clipboard, Tasks, and/or vscode settings
Can toggle some refreshes on and off with use of binary flag system

Assumption:
the ~/projects/home-settings repo has no working changes

refresh_settings() = refresh_settings_with_flags "00"
refresh_settings_all() = refresh_settings_with_flags "111"

Togglable Copies:
- vscode
- clipboard
- Tasks

Binary Flags to pass to refresh_settings_with_flags: (leading zeros can be omitted)
Use to copy the given settings
"001" -- vscode
"010" -- clipboard
"100" -- Tasks
These flags are stackable:
Ex:
refresh_settings_with_flags "011" -- copy vscode and clipboard aswell but not the Tasks

How:
type -a refresh_settings to see implementation
This process tries to retain working changes in the git repo for home-settings for the copy down process
EOF
`
  echo "$docs";
}

function refresh_settings_all {
  refresh_settings "111";
}

function refresh_settings_with_flags {
  local flags="$1";
  [[ -z "$flags" ]] && { echo "Must specify flags" >&2; return 1; }
  refresh_settings "$flags";
}

function search_env_for_fuzz {
  # fuzzy searches through bash env and user defined bash tools
  local search_regex="$1";
  search_regex=${search_regex:+"$(echo "$search_regex" | to_fuzz)"};
  search_env_for "$search_regex";
}

function show_cmds_like_fuzz {
  local pattern="$1";
  [[ -z "$pattern" ]] && { echo "Must specify a command pattern\!" >&2; return 1; }
  pattern=$(echo "$pattern" | to_fuzz);
  show_cmds_like "$pattern";
}

function cdfp {
  local get_project_dir='
    current_path=`pwd`;
    project_dir=`pwd`;
    while [[ ! "$current_path" == "/" ]] ; do
      [[ -d .git ]] && {
        project_dir=`pwd`;
        break;
      }
      cd ..;
      current_path=`pwd`;
    done;
    echo "$project_dir";
  '
  project_dir=$(bash -c "$get_project_dir");
  cd "$project_dir" || { echo "Unable to find project_dir\!" >&2; return 1; }
  cd "$(dirname `FUZZY_FINDER_CDF_PLACEHOLDER`)"  || { echo "Unable to find selected files directory\!" >&2; return 1; };
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

function _find_determine_child_search_roots {
  # only go 1 level into a .gitignore structure
  # if there is nested .gitignores past this, then only take the highest level for the search
  local search_depth_for_nested_git_ignores="$1";
  search_depth_for_nested_git_ignores="${search_depth_for_nested_git_ignores:="$FIND_GIT_DEFAULT_CHILD_GITIGNORE_SEARCH_DEPTH"}";
  [[ $search_depth_for_nested_git_ignores -lt 2 ]] && return;
  local child_git_ignore_roots; child_git_ignore_roots=($(find . -mindepth "2" -maxdepth "$search_depth_for_nested_git_ignores" -name ".gitignore" -exec dirname "{}" \; ;));
  [[ 0 == ${#child_git_ignore_roots[@]} ]] && return;
  local child_git_ignore_roots_trimmed=();
  # TODO: change this index to 0 for bash
  child_git_ignore_roots_trimmed+=(${child_git_ignore_roots[1]});
  for child_git_ignore_root in ${child_git_ignore_roots[@]}; do
    # TODO: change this index to 0 for bash
    local i=1;
    local should_add=0;
    # TODO: change this -le to -lt for bash
    while [ $i -le ${#child_git_ignore_roots_trimmed[@]} ]; do
      if [[ "$child_git_ignore_root" = "${child_git_ignore_roots_trimmed[$i]}"* ]]; then
        # dont add
        # echo "no add ---"
        # echo  "$child_git_ignore_root"
        # echo "trimm entry ${child_git_ignore_roots_trimmed[$i]}"
        ((i++));
        should_add=1;
        break;
      fi
      if [[ "${child_git_ignore_roots_trimmed[$i]}" = "$child_git_ignore_root"* ]]; then
        # replace with parent entry
        # echo "replace"
        # echo  "$child_git_ignore_root"
        # echo "trimm entry ${child_git_ignore_roots_trimmed[$i]}"
        child_git_ignore_roots_trimmed[$i]="$child_git_ignore_root";
        ((i++));
        should_add=1;
        break;
      fi
      ((i++));
    done;
    if [[ "$should_add" == "0" ]]; then
      child_git_ignore_roots_trimmed+=("$child_git_ignore_root");
    fi
  done;
  echo "${child_git_ignore_roots_trimmed[*]}";
}

function _find_git_estimator_ignored_dirs {
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
  # TODO: filter out duplicates
  gitignore_entries+=($(echo "${FIND_GIT_EXTRA_IGNORE_DIRS[@]}"));
  gitignore_entries=($(echo "${gitignore_entries[@]}" | tr ' ' '\n' | sort -u | xargs));
  _find_generate_not_paths "${gitignore_entries[@]}";
}

export FIND_DEFAULT_MAX_DEPTH=9;

function _find_items_rename_helper {
  local file_pattern="$1";
  [[ -z "$file_pattern" ]] && { echo "Must specify a file pattern\!" >&2; return 1; }
  local by="$2";
  [[ -z "$by" ]] && { echo "Must specify a by substitution\!" >&2; return 1; }
  local preview=$3;
  [[ -z "$preview" ]] && { echo "Must specify the preview flag\!" >&2; return 1; }
  local maxdepth="$4";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths="$5";
  for mdepth in $(seq 1 "$maxdepth"); do
    eval "find . -mindepth '$mdepth' -maxdepth '$mdepth' -regextype egrep -iregex '$file_pattern' $not_paths -print0" | while read -d $'\0' item; do
    local new_name; new_name="$(echo "$item" | sed -E "$by")";
    [[ "$item" != "$new_name" ]] && {
      if [[ $preview == false ]]; then
        mv "$item" "$new_name";
      else
        echo "mv" "'$item'" "'$new_name'" ";";
      fi
    }
    done;
  done;
}

function find_items_rename_preview {
  local not_paths; not_paths=$(_find_default_ignored_dirs);
  _preview_warning_message;
  _find_items_rename_helper "$1" "$2" true "$3" "$not_paths";
}

function afind_items_rename_preview {
  local not_paths="";
  _preview_warning_message;
  _find_items_rename_helper "$1" "$2" true "$3" "$not_paths";
}

function gfind_items_rename_preview {
  local not_paths; not_paths=$(_find_git_estimator_ignored_dirs);
  _preview_warning_message;
  _find_items_rename_helper "$1" "$2" true "$3" "$not_paths";
}

function find_items_rename {
  local not_paths; not_paths=$(_find_default_ignored_dirs);
  _find_items_rename_helper "$1" "$2" false "$3" "$not_paths";
}

function afind_items_rename {
  local not_paths="";
  _find_items_rename_helper "$1" "$2" false "$3" "$not_paths";
}

function gfind_items_rename {
  local not_paths; not_paths=$(_find_git_estimator_ignored_dirs);
  _find_items_rename_helper "$1" "$2" false "$3" "$not_paths";
}

function _find_items_delete_helper {
  local file_pattern="$1";
  [[ -z "$file_pattern" ]] && { echo "Must specify a file pattern\!" >&2; return 1; }
  local preview=$2;
  [[ -z "$preview" ]] && { echo "Must specify the preview flag\!" >&2; return 1; }
  local maxdepth="$3";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths="$4";
  for mdepth in $(seq 1 "$maxdepth"); do
    eval "find . -mindepth '$mdepth' -maxdepth '$mdepth' -regextype egrep -iregex '$file_pattern' $not_paths -print0" | while read -d $'\0' item; do
      if [[ $preview == false ]]; then
        rm -rf "$item";
      else
        echo "rm -rf" "'$item'" ";";
      fi
    done;
  done;
}

function _preview_warning_message {
  echo "NOTE: This behavior may not be the exact behavior when running the command out of preview mode";
}

function find_items_delete_preview {
  local not_paths; not_paths=$(_find_default_ignored_dirs);
  _preview_warning_message;
  _find_items_delete_helper "$1" true "$2" "$not_paths";
}

function afind_items_delete_preview {
  local not_paths="";
  _preview_warning_message;
  _find_items_delete_helper "$1" true "$2" "$not_paths";
}

function gfind_items_delete_preview {
  local not_paths; not_paths=$(_find_git_estimator_ignored_dirs);
  _preview_warning_message;
  _find_items_delete_helper "$1" true "$2" "$not_paths";
}

function find_items_delete {
  local not_paths; not_paths=$(_find_default_ignored_dirs);
  _find_items_delete_helper "$1" false "$2" "$not_paths";
}

function afind_items_delete {
  local not_paths="";
  _find_items_delete_helper "$1" false "$2" "$not_paths";
}

function gfind_items_delete {
  local not_paths; not_paths=$(_find_git_estimator_ignored_dirs);
  _find_items_delete_helper "$1" false "$2" "$not_paths";
}

function _find_items_helper {
  local file_pattern="$1";
  [[ -z "$file_pattern" ]] && { echo "Must specify a file pattern\!" >&2; return 1; }
  local maxdepth="$2";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths="$3";
  eval "find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' $not_paths";
}

function find_items {
  local not_paths; not_paths=$(_find_default_ignored_dirs);
  _find_items_helper "$1" "$2" "$not_paths";
}

function afind_items {
  local not_paths="";
  _find_items_helper "$1" "$2" "$not_paths";
}

function gfind_items {
  local not_paths; not_paths=$(_find_git_estimator_ignored_dirs);
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
  [[ -z "$file_pattern" ]] && { echo "Must specify a file pattern\!" >&2; return 1; }
  local with_content="$2";
  local maxdepth="$3";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths="$4";
  if [[ -z "$with_content" ]]; then
    eval "find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' -type f $not_paths -exec echo rm \"'{}' ;\" \;";
  else
    eval "find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' -type f $not_paths -exec grep -Ein -e '$with_content' \"{}\" \; -exec echo rm \"'{}' ;\" \;" | grep -E "^rm";
  fi
}

function _find_files_delete_helper {
  local file_pattern="$1";
  [[ -z "$file_pattern" ]] && { echo "Must specify a file pattern\!" >&2; return 1; }
  local with_content="$2";
  local maxdepth="$3";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths; not_paths=$(_find_default_ignored_dirs);
  if [[ -z "$with_content" ]]; then
    eval "find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' -type f $not_paths -exec rm \"{}\" \;";
  else
    eval "find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' -type f $not_paths -exec grep -Ein -e '$with_content' \"{}\" \; -exec rm \"{}\" \;" > /dev/null;
  fi
}

function find_files_delete_preview {
  local not_paths; not_paths=$(_find_default_ignored_dirs);
  _find_files_delete_preview_helper "$1" "$2" "$3" "$not_paths";
}

function afind_files_delete_preview {
  local not_paths="";
  _find_files_delete_preview_helper "$1" "$2" "$3" "$not_paths";
}

function gfind_files_delete_preview {
  local not_paths; not_paths=$(_find_git_estimator_ignored_dirs);
  _find_files_delete_preview_helper "$1" "$2" "$3" "$not_paths";
}

function find_files_delete {
  local not_paths; not_paths=$(_find_default_ignored_dirs);
  _find_files_delete_helper "$1" "$2" "$3" "$not_paths";
}

function afind_files_delete {
  local not_paths="";
  _find_files_delete_helper "$1" "$2" "$3" "$not_paths";
}

function gfind_files_delete {
  local not_paths; not_paths=$(_find_git_estimator_ignored_dirs);
  _find_files_delete_helper "$1" "$2" "$3" "$not_paths";
}

function _find_files_rename_helper {
  local file_pattern="$1";
  [[ -z "$file_pattern" ]] && { echo "Must specify a file pattern\!" >&2; return 1; }
  local by="$2";
  [[ -z "$by" ]] && { echo "Must specify a by substitution\!" >&2; return 1; }
  local with_content="$3";
  local preview=$4
  [[ -z "$preview" ]] && { echo "Must specify the preview flag\!" >&2; return 1; }
  local maxdepth="$5";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths="$6";
  eval "find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' -type f $not_paths -print0" | while read -d $'\0' file; do
  local should_rename=false;
  if [[ -z "$with_content" ]]; then
    should_rename=true;
  else
    file_content_matches="$(grep -Ein "$with_content" "$file")"
    [[ -z "$file_content_matches" ]] || { should_rename=true; }
  fi
  [[ $should_rename == true ]] && {
    local b nb new_name;
    b=$(basename "$file");
    nb="$(echo "$b" | sed -E "$by")";
    new_name="$(dirname "$file")/$nb"
    [[ "$file" != "$new_name" ]] && {
      if [[ $preview == false ]]; then
        mv "$file" "$new_name";
      else
        echo "mv" "'$file'" "'$new_name'" ";";
      fi
    }
  }
  done;
}

function find_files_rename_preview {
  local not_paths; not_paths=$(_find_default_ignored_dirs);
  _find_files_rename_helper "$1" "$2" "$3" true "$4" "$not_paths";
}

function afind_files_rename_preview {
  local not_paths="";
  _find_files_rename_helper "$1" "$2" "$3" true "$4" "$not_paths";
}

function gfind_files_rename_preview {
  local not_paths; not_paths=$(_find_git_estimator_ignored_dirs);
  _find_files_rename_helper "$1" "$2" "$3" true "$4" "$not_paths";
}

function find_files_rename {
  local not_paths; not_paths=$(_find_default_ignored_dirs);
  _find_files_rename_helper "$1" "$2" "$3" false "$4" "$not_paths";
}

function afind_files_rename {
  local not_paths="";
  _find_files_rename_helper "$1" "$2" "$3" false "$4" "$not_paths";
}

function gfind_files_rename {
  local not_paths; not_paths=$(_find_git_estimator_ignored_dirs);
  _find_files_rename_helper "$1" "$2" "$3" false "$4" "$not_paths";
}

function _find_files_helper {
  local file_pattern="$1";
  [[ -z "$file_pattern" ]] && { echo "Must specify a file pattern\!" >&2; return 1; }
  local with_content="$2";
  local maxdepth="$3";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths="$4";
  if [[ -z "$with_content" ]]; then
    eval "find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' -type f $not_paths";
  else
    eval "find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' -type f $not_paths -exec grep -Ein -e '$with_content' \"{}\" \; -exec echo \"{}\" \;" | grep -Ev "\s*^[[:digit:]]+:";
  fi
}

function find_files {
  local not_paths; not_paths=$(_find_default_ignored_dirs);
  _find_files_helper "$1" "$2" "$3" "$not_paths";
}

function afind_files {
  local not_paths="";
  _find_files_helper "$1" "$2" "$3" "$not_paths";
}

function gfind_files {
  local not_paths; not_paths=$(_find_git_estimator_ignored_dirs);
  local child_search_roots; child_search_roots=($(_find_determine_child_search_roots "$4"));
  local child_not_path_roots="";
  for child_search_root in ${child_search_roots[@]}; do
    child_not_path_roots="$child_not_path_roots -not -path '$child_search_root/*'";
  done;
  child_not_path_roots="${child_not_path_roots+" $child_not_path_roots"}";
  echo "root not paths: ${not_paths}${child_not_path_roots}"
  echo "----------Root Result"
  _find_files_helper "$1" "$2" "$3" "${not_paths}${child_not_path_roots}";
  for child_search_root in ${child_search_roots[@]}; do
    if [[ -d "$child_search_root" ]]; then
      echo "----------Results for $child_search_root"
    (
      cd "$child_search_root";
      # This could be slightly optimized to use the exist not_paths var and glue on unread gitignore not paths to it
      #   rathern than recreating the not paths from scratch for every child
      local x="$(_find_git_estimator_ignored_dirs)";
      echo "$x";
      _find_files_helper "$1" "$2" "$3" "$x";
    )
    fi
  done;
}

function find_files_fuzz {
  local not_paths; not_paths=$(_find_default_ignored_dirs);
  _find_files_helper "$(echo "$1" | to_fuzz)" "$2" "$3" "$not_paths";
}

function afind_files_fuzz {
  local not_paths="";
  _find_files_helper "$(echo "$1" | to_fuzz)" "$2" "$3" "$not_paths";
}

function gfind_files_fuzz {
  local not_paths; not_paths=$(_find_git_estimator_ignored_dirs);
  _find_files_helper "$(echo "$1" | to_fuzz)" "$2" "$3" "$not_paths";
}

function _find_in_files_helper {
  local grep_pattern="$1";
  [[ -z "$grep_pattern" ]] && { echo "Must specify a grep pattern\!" >&2; return 1; }
  local file_pattern="$2";
  [[ -z "$file_pattern" ]] && { file_pattern=".*"; }
  local maxdepth="$3";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths="$4";
  eval "find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' -type f $not_paths -exec grep -E --with-filename --color -in -e '$grep_pattern' \"{}\" +;";
}

function find_in_files {
  local not_paths; not_paths=$(_find_default_ignored_dirs);
  _find_in_files_helper "$1" "$2" "$3" "$not_paths";
}

function afind_in_files {
  local not_paths="";
  _find_in_files_helper "$1" "$2" "$3" "$not_paths";
}

function gfind_in_files {
  local not_paths; not_paths=$(_find_git_estimator_ignored_dirs);
  _find_in_files_helper "$1" "$2" "$3" "$not_paths";
}

function find_in_files_fuzz {
  local not_paths; not_paths=$(_find_default_ignored_dirs);
  _find_in_files_helper "$(echo "$1" | to_fuzz)" "$2" "$3" "$not_paths";
}

function afind_in_files_fuzz {
  local not_paths="";
  _find_in_files_helper "$(echo "$1" | to_fuzz)" "$2" "$3" "$not_paths";
}

function gfind_in_files_fuzz {
  local not_paths; not_paths=$(_find_git_estimator_ignored_dirs);
  _find_in_files_helper "$(echo "$1" | to_fuzz)" "$2" "$3" "$not_paths";
}

function _find_in_files_replace_helper {
  local by="$1";
  [[ -z "$by" ]] && { echo "Must specify a by substitution\!" >&2; return 1; }
  local file_pattern="$2";
  [[ -z "$file_pattern" ]] && { file_pattern=".*"; }
  local maxdepth="$3";
  [[ -z "$maxdepth" ]] && { maxdepth=$FIND_DEFAULT_MAX_DEPTH; }
  local not_paths="$4";
  eval "find . -maxdepth '$maxdepth' -regextype egrep -iregex '$file_pattern' -type f $not_paths -exec sed -E -i'' '$by' \"{}\" \;";
}

function find_in_files_replace {
  local not_paths; not_paths=$(_find_default_ignored_dirs);
  _find_in_files_replace_helper "$1" "$2" "$3" "$not_paths";
}

function afind_in_files_replace {
  local not_paths="";
  _find_in_files_replace_helper "$1" "$2" "$3" "$not_paths";
}

function gfind_in_files_replace {
  local not_paths; not_paths=$(_find_git_estimator_ignored_dirs);
  _find_in_files_replace_helper "$1" "$2" "$3" "$not_paths";
}

function cdp {
  local items="";
  tmuxps_get_project_dirs;
  for _path in $(echo "${TMUXPS_PROJECT_DIRS[@]}" | tr " " "\n"); do
    [[ -d "$_path" ]] && {
      items+=`find "$_path" -maxdepth 1 -mindepth 1 -type d`;
      items+="\n";
    }
  done;
  local selected; selected=$(printf "$items" | FUZZY_FINDER_PLACEHOLDER);
  cd "$selected" || { echo "Unable to find selected project\!" >&2; return 1; }
}

function docker_local {
  local environment="${1:-"dev"}";
  local containers="$2";
  local extra_env_files_pattern="${3}";
  local env_file_location="${4:-"my.scripts.d/env"}";
  local output_env_file="${5:-".env"}";
  local compose_base="${6:-"docker-compose.yml"}";
  local compose_ext="${7:-"docker-compose.local.yml"}";
  echo "" > "$output_env_file";
  find "./$env_file_location/base" -type f -name "*.env*" -print0 | while read -d $'\0' cur_env_file; do
    {
      echo "# $cur_env_file BEGIN -------------------";
      cat "$cur_env_file";
      echo "";
    } >> "$output_env_file";
  done;
  find "./$env_file_location/$environment" -type f -name "*.env*" -print0 | while read -d $'\0' cur_env_file; do
    {
      echo "# $cur_env_file BEGIN -------------------";
      cat "$cur_env_file";
      echo "";
    } >> "$output_env_file";
  done;
  if [[ -n "$extra_env_files_pattern" ]]; then
    find "./$env_file_location" -maxdepth 1 -regextype egrep -iregex "$extra_env_files_pattern" -type f -print0 | while read -d $'\0' cur_env_file; do
      {
        echo "# $cur_env_file BEGIN -------------------";
        cat "$cur_env_file";
        echo "";
      } >> "$output_env_file";
    done;
  fi
  docker compose -f "$compose_base" -f "$compose_ext" down;
  docker compose -f "$compose_base" -f "$compose_ext" up -d $containers;
}

function git_deploy {
  local origin_branch_choices="$1";
  local destination_branch_choices="$2";
  local g_origin_branch_choices; g_origin_branch_choices="$(echo "${GIT_ORIGIN_BRANCH_CHOICES[@]}")";
  local g_destination_branch_choices; g_destination_branch_choices="$(git_main_branch) $(echo "${GIT_DESTINATION_BRANCH_CHOICES[@]}")";
  origin_branch_choices=($(echo "${origin_branch_choices:=$g_origin_branch_choices}" | xargs));
  destination_branch_choices=($(echo "${destination_branch_choices:=$g_destination_branch_choices}" | xargs));
  local origin_branch='';
  for origin_branch_choice in ${origin_branch_choices[@]}; do
    if git show-ref --quiet "refs/heads/${origin_branch_choice}"; then origin_branch="$origin_branch_choice"; fi
  done;
  local destination_branch='';
  for destination_branch_choice in ${destination_branch_choices[@]}; do
    if git show-ref --quiet "refs/heads/${destination_branch_choice}"; then destination_branch="$destination_branch_choice"; fi
  done;
  echo "Origin Branch: $origin_branch";
  echo "Destination Branch: $destination_branch";
  [[ -z "$origin_branch" ]] && { echo "No origin branch found from choices: ${origin_branch_choices[@]}!" >&2; return 1; }
  [[ -z "$destination_branch" ]] && { echo "No destination branch found from choices: ${destination_branch_choices[@]}!" >&2; return 1; }
  git checkout "$origin_branch" && git pull && git push && git checkout "$destination_branch" && git pull && git merge "$origin_branch" --commit --no-edit && git push && git checkout "$origin_branch";
}

function git_all_the_things {
  git branch -r | grep -v '\->' | while read remote; do
    git branch --track "${remote#origin/}" "$remote";
  done;
  git fetch --all --prune;
  git pull --all --prune;
}

function git_checkout_branch_in_path {
  local branches="$1";
  local _path="$2";
  [[ -z "$branches" ]] && { echo "Must specify a string of branches delimited by spaces\!" >&2; return 1; }
  branches=($(echo "$branches" | xargs));
  _path="${_path:="."}";
  _dirs=($(find "$_path" -mindepth 1 -maxdepth 1 -type d | xargs));
  for proj in ${_dirs[@]}; do
    echo "Project: $proj";
    cd "$proj" || continue;
    git status >/dev/null 2>&1 && git_all_the_things;
    local is_git_repo="$?";
    [[ ! "$is_git_repo" == "0" ]] && {
      cd .. && continue;
    }
    for branch in ${branches[@]}; do
      # Breaks out of loop for the first branch that checks out successfully
      git checkout "$branch" && break;
    done;
    git pull;
    cd ..;
  done;
}

function git_log_follow {
  # search current branch git commits for commits that change a file
  local item_name="$1";
  [[ -z "$item_name" ]] && { echo "Must specify item_name\!" >&2; return 1; }
  git log --date-order --ignore-space-change --follow -- "$item_name";
}

function git_diff_range {
  # assumption from commit is older than to commit
  [[ -z "$1" ]] && { echo "Must specify from\!" >&2; return 1; }
  [[ -z "$2" ]] && { echo "Must specify to\!" >&2; return 1; }
  local from=$(($1 + 1));
  local to=$(($2 + 1));
  local commits; commits="$(git --no-pager log --oneline -n "$from" | col_n 1 | xargs)";
  local from_commit; from_commit="$(echo "$commits" | col_n "$from")";
  local to_commit; to_commit="$(echo "$commits" | col_n "$to")";
  git diff --ignore-space-change "$from_commit" "$to_commit";
}

function git_log_show_last_n_on_current_branch {
  local n="$1";
  [[ -z "$n" ]] && { echo "Must specify n\!" >&2; return 1; }
  git --no-pager log --oneline -n "$n" | perl -nle '$i=$.-1; print "$i $_"';
}

function git_diff_of_commit {
  local commit="$1";
  [[ -z "$commit" ]] && { echo "Must specify a commit\!" >&2; return 1; }
  git diff --ignore-space-change "$commit"^! ;
}

function git_diff_from_commit_to_current {
  local commit="$1";
  [[ -z "$commit" ]] && { echo "Must specify a commit\!" >&2; return 1; }
  git diff --ignore-space-change "$commit"^;
}

function git_rebase_i_head {
  local n="$1";
  [[ -z "$n" ]] && { echo "Must specify a n\!" >&2; return 1; }
  git rebase -i HEAD~"$n";
}

function git_sweep {
  local exclude_branches; exclude_branches="$(git_main_branch;)|$(echo "$GIT_DESTINATION_BRANCH_CHOICES $GIT_ORIGIN_BRANCH_CHOICES" | tr " " "|")";
  git branch -d $(git branch --merged | grep -Ev "(^\\*|^\\s*($exclude_branches)$)");
}

function show_script_path {
  local scriptpath; scriptpath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";
  echo "$scriptpath";
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

function convert_csv_to_json {
  local csv="$1";
  if [[ -e "$csv" ]]; then
    pwsh -command "&{ Get-Content $csv | ConvertFrom-Csv | ConvertTo-Json; }";
  else
    rows=$(echo "$csv" | tr -d '"' | sed -E 's/(.*)/"\1",/g');
    rows=$(echo "$rows" | perl -0777 -ple "s/,\$//");
    rows=$(echo "(" "$rows" ")");
    pwsh -command "&{ $rows | ConvertFrom-Csv | ConvertTo-Json; }";
  fi
}

function csv_delimiter_check_single_line {
  local csv_like="$1";
  local delimiter="$2";
  [[ -z "$csv_like" ]] && { echo "Must specify a csv_like file or string\!" >&2; return 1; }
  echo "${delimiter:=","}" >/dev/null;
  [[ -e "$csv_like" ]] && { csv_like=$(cat "$csv_like"); }
  echo "$csv_like" | tr -d -c "${delimiter}\n" | awk '{ print length; }' | sort -n | uniq -c;
}

function _rest_temp_response_loc {
  echo "/tmp/responses/";
}

function _rest_get_query_params {
  local url="$1";
  local query_params; query_params=$(echo "$url" | sed -E "s/([^?]*?)\??(.*?)/\2/g");
  [[ -n "$query_params" ]] && { rest_encode_url "$query_params"; }
}

function _rest_get_base_url_with_endpoint {
  local url="$1";
  echo "$url" | sed -E "s/([^?]*?)\??(.*?)/\1/g";
}

function _rest_format_and_print_response {
  local _file="$1";
  prettier --write "$_file";
  cat "$_file";
}

function rest_encode_url {
  local url="$1";
  [[ -z "$url" ]] && { echo "Must specify url\!" >&2; return 1; }
  echo "$url" | sed 's, ,%20,g;s,\!,%21,g;s,",%22,g;s,#,%23,g;s,\$,%24,g;s,'"'"',%27,g;';
}


function _rest_helper {
  local url="$1";
  local request_body="$2";
  local curl_flags="$3";
  local response_file_type="$4";
  local method="$5";
  local headers="$6";
  local trailing_command="$7";
  [[ -z "$url" ]] && { echo "Must specify url\!" >&2; return 1; }
  echo "${content_type:="application/json"}" >/dev/null;
  echo "${curl_flags:="Lk"}" >/dev/null;
  echo "${response_file_type:="json"}" >/dev/null;
  temp_response_loc=$(_rest_temp_response_loc);
  mkdir -p "$temp_response_loc";
  local base_url_with_endpoint; base_url_with_endpoint=$(_rest_get_base_url_with_endpoint "$url");
  local _file; _file="${temp_response_loc}$(basename "$base_url_with_endpoint" | tr "/" "_").${response_file_type}";
  local query_params; query_params=$(_rest_get_query_params "$url");
  [[ -e "$request_body" ]] && { request_body=$(cat "$request_body"); }
  request_body=$(echo "${request_body:+"-d '$request_body'"}");
  [[ ! "$curl_flags" == "-"* ]] && { curl_flags=$(echo "${curl_flags:+"-$curl_flags"}"); }
  [[ ! "$query_params" == "?"* ]] && { query_params=$(echo "${query_params:+"?$query_params"}"); }
  [[ ! "$method" == " -X"* ]] && { method=$(echo "${method:+" -X $method"}"); }
  [[ ! "$query_params" == "?"* ]] && { query_params=$(echo "${query_params:+"?$query_params"}"); }
  [[ ! "$trailing_command" == " "* ]] && { trailing_command=$(echo "${trailing_command:+" $trailing_command"}"); }
  [[ ! "$request_body" == " "* ]] && { request_body=$(echo "${request_body:+" $request_body"}"); }
  [[ ! "$headers" == " "* ]] && { headers=$(echo "${headers:+" $headers"}"); }
  url=" \"${base_url_with_endpoint}${query_params}\"";
  bash -c "
    curl $curl_flags$method$request_body$url$headers$trailing_command
  " > "$_file";
  _rest_format_and_print_response "$_file";
}

function _rest_helper_preper {
  local url="$1";
  local request_body="$2";
  local curl_flags="$3";
  local auth="$4";
  local response_file_type="$5";
  local content_type="$6";
  local extra_headers="$7";
  local trailing_command="$8";
  local method="$9";
  # authorization is mainly for Bearer token style auth
  if [[ ! "$auth" == *":"* ]]; then
    auth=$(echo ${auth:+"-H \"Authorization: Bearer $auth\""});
  else
    auth=$(echo ${auth:+"-H '$auth'"});
  fi
  [[ ! "$extra_headers" == " "* ]] && { extra_headers=$(echo "${extra_headers:+" $extra_headers"}"); }
  local headers; headers="${content_type:+"-H \"Content-Type: $content_type\""} ${auth}${extra_headers}";
  _rest_helper "$url" "$request_body" "$curl_flags" "$response_file_type" "$method" "$headers" "$trailing_command";
}

function rest_get {
  declare -a inputs; inputs=($@);
  inputs+=("GET");
  _rest_helper_preper $inputs[@];
}

function rest_post {
  declare -a inputs; inputs=($@);
  inputs+=("POST");
  _rest_helper_preper $inputs[@];
}

function rest_patch {
  declare -a inputs; inputs=($@);
  inputs+=("PATCH");
  _rest_helper_preper $inputs[@];
}

function rest_delete {
  declare -a inputs; inputs=($@);
  inputs+=("DELETE");
  _rest_helper_preper $inputs[@];
}

function rest_generic {
  method="$9";
  [[ -z "$method" ]] && { echo "Must specify method\!" >&2; return 1; }
  declare -a inputs; inputs=($@);
  inputs+=("$method");
  _rest_helper_preper $inputs[@];
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

