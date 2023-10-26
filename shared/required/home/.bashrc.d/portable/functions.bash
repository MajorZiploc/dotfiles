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
  session_name=$(echo "$session_name" | tr ':.[[:blank:]]' '-');
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
      session_name=$(basename "$selected" | tr ':.[[:blank:]]' '-');
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
  local selected;
  if which zoxide &>/dev/null ; then
    selected=$(zoxide query -l | FUZZY_FINDER_PLACEHOLDER);
    zoxide add "$selected";
  else
    tmuxps_get_project_dirs;
    for _path in $(echo "${TMUXPS_PROJECT_DIRS[@]}" | tr " " "\n"); do
      [[ -d "$_path" ]] && {
        items+=$(find "$_path" -maxdepth 1 -mindepth 1 -type d);
        items+="\n";
      }
    done;
    selected=$(printf "%s" "$items" | FUZZY_FINDER_PLACEHOLDER);
  fi
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

function show_file_content {
  # displays file contents lead by the name of the file
  # files=$@
  echo "Files: $@";
  echo "";
  tail -n +1 $@;
}

function refresh_settings_help {
local docs=`cat << EOF
Purpose:
Refresh your bash, vim, clipboard, Tasks, and/or vscode settings
Can toggle some refreshes on and off with use of binary flag system

Assumption:
the ~/projects/dotfiles repo has no working changes

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
This process tries to retain working changes in the git repo for dotfiles for the copy down process
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
  local project_dir; project_dir="$(
    current_path="$(pwd)";
    project_dir="$(pwd)";
    while [[ ! "$current_path" == "/" ]] ; do
      [[ -d .git ]] && {
        project_dir="$(pwd)";
        break;
      }
      cd ..;
      current_path="$(pwd)";
    done;
    echo "$project_dir";
  )";
  cd "$project_dir" || { echo "Unable to find project_dir\!" >&2; return 1; }
  cd "$(dirname `FUZZY_FINDER_CDF_PLACEHOLDER`)"  || { echo "Unable to find selected files directory\!" >&2; return 1; };
}

function cdp {
  local items="";
  if which zoxide &>/dev/null ; then
    selected=$(zoxide query -l | FUZZY_FINDER_PLACEHOLDER);
    zoxide add "$selected";
  else
    tmuxps_get_project_dirs;
    for _path in $(echo "${TMUXPS_PROJECT_DIRS[@]}" | tr " " "\n"); do
      [[ -d "$_path" ]] && {
        items+=`find "$_path" -maxdepth 1 -mindepth 1 -type d`;
        items+="\n";
      }
    done;
    local selected; selected=$(printf "%s" "$items" | FUZZY_FINDER_PLACEHOLDER);
  fi
  cd "$selected" || { echo "Unable to find selected project\!" >&2; return 1; }
}

function docker_create_env_file {
  local environment="${1:-"dev"}";
  local extra_env_files_pattern="${2}";
  local env_file_location="${3:-"my.scripts.d/env"}";
  local output_env_file="${4:-".env"}";
  echo "" > "$output_env_file";
  find "./$env_file_location/base" -type f -name "*.env*" -print0 | while read -r -d $'\0' cur_env_file; do
    {
      echo "# $cur_env_file BEGIN -------------------";
      cat "$cur_env_file";
      echo "";
    } >> "$output_env_file";
  done;
  find "./$env_file_location/$environment" -type f -name "*.env*" -print0 | while read -r -d $'\0' cur_env_file; do
    {
      echo "# $cur_env_file BEGIN -------------------";
      cat "$cur_env_file";
      echo "";
    } >> "$output_env_file";
  done;
  if [[ -n "$extra_env_files_pattern" ]]; then
    find "./$env_file_location" -maxdepth 1 -regextype egrep -iregex "$extra_env_files_pattern" -type f -print0 | while read -r -d $'\0' cur_env_file; do
      {
        echo "# $cur_env_file BEGIN -------------------";
        cat "$cur_env_file";
        echo "";
      } >> "$output_env_file";
    done;
  fi
}

function git_log_diff {
  if [[ -z "$GIT_COLOR_WORDS" ]]; then
    git log --stat -p --ignore-space-change $@;
  else
    git log --stat -p --ignore-space-change --color-words="$GIT_COLOR_WORDS" $@;
  fi
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
  git branch -r | grep -v '\->' | while read -r remote; do
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
  if [[ -z "$GIT_COLOR_WORDS" ]]; then
    git log --date-order --ignore-space-change --follow -- "$item_name";
  else
    git log --color-words="$GIT_COLOR_WORDS" --date-order --ignore-space-change --follow -- "$item_name";
  fi
}

function git_diff_range {
  [[ -z "$1" ]] && { echo "Must specify from\!" >&2; return 1; }
  [[ -z "$2" ]] && { echo "Must specify to\!" >&2; return 1; }
  local from=$(($1 + 1));
  local to=$(($2 + 1));
  [[ $from -le 0 || $to -le 0 ]] && { echo "from and to must be greater than or equal to 0\!" >&2; return 1; }
  [[ $from -le $to ]] && { echo "from must be greater than to\!" >&2; return 1; }
  local commits; commits="$(git --no-pager log --oneline -n "$from" | col_n 1 | xargs)";
  local from_commit; from_commit="$(echo "$commits" | col_n "$from")";
  local to_commit; to_commit="$(echo "$commits" | col_n "$to")";
  if [[ -z "$GIT_COLOR_WORDS" ]]; then
    git diff --ignore-space-change "$from_commit" "$to_commit";
  else
    git diff --color-words="$GIT_COLOR_WORDS" --ignore-space-change "$from_commit" "$to_commit";
  fi
}

function git_log_show_last_n_on_current_branch {
  local n="$1";
  [[ -z "$n" ]] && { echo "Must specify n\!" >&2; return 1; }
  git --no-pager log --oneline -n "$n" | perl -nle '$i=$.-1; print "$i $_"';
}

function git_diff_of_commit {
  local commit="$1";
  [[ -z "$commit" ]] && { echo "Must specify a commit\!" >&2; return 1; }
  if [[ -z "$GIT_COLOR_WORDS" ]]; then
    git diff --ignore-space-change "$commit"^!;
  else
    git diff --color-words="$GIT_COLOR_WORDS" --ignore-space-change "$commit"^!;
  fi
}

function git_diff_from_commit_to_current {
  local commit="$1";
  [[ -z "$commit" ]] && { echo "Must specify a commit\!" >&2; return 1; }
  if [[ -z "$GIT_COLOR_WORDS" ]]; then
    git diff --ignore-space-change "$commit"^;
  else
    git diff --color-words="$GIT_COLOR_WORDS" --ignore-space-change "$commit"^;
  fi
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

function convert_csv_to_json {
  local csv="$1";
  if [[ -e "$csv" ]]; then
    pwsh -command "&{ Get-Content $csv | ConvertFrom-Csv | ConvertTo-Json; }";
  else
    rows=$(echo "$csv" | tr -d '"' | sed -E 's/(.*)/"\1",/g');
    rows=$(echo "$rows" | perl -0777 -ple "s/,\$//");
    rows="($rows)";
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
  request_body="${request_body:+"-d '$request_body'"}";
  [[ ! "$curl_flags" == "-"* ]] && { curl_flags="${curl_flags:+"-$curl_flags"}"; }
  [[ ! "$query_params" == "?"* ]] && { query_params="${query_params:+"?$query_params"}"; }
  [[ ! "$method" == " -X"* ]] && { method="${method:+" -X $method"}"; }
  [[ ! "$query_params" == "?"* ]] && { query_params="${query_params:+"?$query_params"}"; }
  [[ ! "$trailing_command" == " "* ]] && { trailing_command="${trailing_command:+" $trailing_command"}"; }
  [[ ! "$request_body" == " "* ]] && { request_body="${request_body:+" $request_body"}"; }
  [[ ! "$headers" == " "* ]] && { headers="${headers:+" $headers"}"; }
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
    auth="${auth:+"-H \"Authorization: Bearer $auth\""}";
  else
    auth="${auth:+"-H '$auth'"}";
  fi
  [[ ! "$extra_headers" == " "* ]] && { extra_headers="${extra_headers:+" $extra_headers"}"; }
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

function zoxide_refresh_projects {
  tmuxps_get_project_dirs;
  local all_existing_projects_for_path;
  local all_zoxide_entries_for_path;
  local does_zoxide_entry_exist;
  for _path in $(echo "${TMUXPS_PROJECT_DIRS[@]}" | tr " " "\n"); do
    all_existing_projects_for_path="";
    [[ -d "$_path" ]] && {
      find "$_path" -maxdepth 1 -mindepth 1 -type d -print0 | while read -r -d $'\0' project; do
        zoxide query "$project" &>/dev/null;
        zoxide_result_exit_code=$?;
        if [ ! $zoxide_result_exit_code -eq 0 ]; then
          zoxide add "$project";
        fi
        all_existing_projects_for_path+=" $project";
      done
      all_zoxide_entries_for_path=$(zoxide query -l | grep "$_path");
      for zoxide_entry_for_path in $(echo "${all_zoxide_entries_for_path}" | tr " " "\n"); do
        echo "all_zoxide_entries_for_path" | grep "$zoxide_entry_for_path" &> /dev/null;
        does_zoxide_entry_exist=$?;
        if [ $does_zoxide_entry_exist -eq 0 ]; then
          zoxide remove "$zoxide_entry_for_path";
        fi
      done;
    }
  done;
}

function wezterm_background_off {
  sed -Ei 's,^(\s*)(get_wallpaper.* -- background)$,\1-- \2,' ~/.wezterm.lua;
  sed -Ei 's,^(\s*)-- (get_no_wallpaper.* -- no_background)$,\1\2,' ~/.wezterm.lua;
}

function wezterm_background_on {
  sed -Ei 's,^(\s*)-- (get_wallpaper.* -- background)$,\1\2,' ~/.wezterm.lua;
  sed -Ei 's,^(\s*)(get_no_wallpaper.* -- no_background)$,\1-- \2,' ~/.wezterm.lua;
}

function wezterm_transparency_off {
  sed -Ei 's,^(\s*)(opacity.* -- wallpaper_opacity)$,\1-- \2,' ~/.wezterm.lua;
}

function wezterm_transparency_on {
  sed -Ei 's,^(\s*)-- (opacity.* -- wallpaper_opacity)$,\1\2,' ~/.wezterm.lua;
}

function _just_run {
  if [[ -e ./just.bash ]]; then
    . ./just.bash;
    just_run;
  elif [[ -e ./my.scripts.d/just.bash ]]; then
    . ./my.scripts.d/just.bash;
    just_run;
  elif [[ -e ./package.json ]]; then
    npm run start;
  elif [[ -e ./Cargo.toml ]]; then
    RUSTFLAGS="-Awarnings" cargo run;
  elif [[ -e ./composer.json ]]; then
    composer run start;
  fi
}

function _just_install {
  if [[ -e ./just.bash ]]; then
    . ./just.bash;
    just_install;
    just_build;
  elif [[ -e ./my.scripts.d/just.bash ]]; then
    . ./my.scripts.d/just.bash;
    just_install;
    just_build;
  else
    if [[ -e ./package.json ]]; then
      npm i;
    fi
    if [[ -e ./requirements.txt || -e ./setup.py ]]; then
      [[ ! -e "./.venv" ]] && { python3 -m venv "./.venv"; }
      . "./.venv/bin/activate";
      pip3 install wheel;
      if [[ -e ./setup.py ]]; then
        pip3 install -e ".";
      elif [[ -e ./requirements.txt ]]; then
        pip3 install -r ./requirements.txt;
      fi
    fi
    if [[ -e ./Cargo.toml ]]; then
      cargo build;
    fi
    if [[ -e ./composer.json ]]; then
      composer install;
    fi
  fi
}
