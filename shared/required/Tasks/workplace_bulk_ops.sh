# NOTE: Need to set MY_WORKPLACE_PROJECT_DIRS env var for these scripts
# falls back to TMUXPS_PROJECT_DIRS
# export MY_WORKPLACE_PROJECT_DIRS=export MY_WORKPLACE_PROJECT_DIRS=("$(find ~ -mindepth 1 -maxdepth 1 -iname "*projects-workplace-name*" -type d -not -path '*/__pycache__/*' -not -path '*/bin/*' -not -path '*/obj/*' -not -path '*/.git/*' -not -path '*/.svn/*' -not -path '*/node_modules/*' -not -path '*/.ionide/*' -not -path '*/.venv/*' 2>/dev/null)");
#
# if you want to filter less files out of your search
# export FIND_GIT_DEFAULT_CHILD_GITIGNORE_SEARCH_DEPTH="0";
#
# change project_patterns argument name to avoid clashing with possible searches
# export MY_WORKPLACE_PROJECT_PATTERNS_ARG_NAME="project_patterns";
#
# best to set these env vars in your shell's rc file

function workplace_find_files {
  local project_patterns_arg="--${MY_WORKPLACE_PROJECT_PATTERNS_ARG_NAME:-project_patterns}=";
  local args=($@);
  if [[ "${args}" == "$project_patterns_arg"* ]]; then
    local project_patterns="${args[1]}";
    project_patterns="${project_patterns/"${project_patterns_arg}"/}";
    args=("${args[@]:1}");
  else
    local project_patterns=".*";
  fi
  if [[ "${args[*]}" == *"$project_patterns_arg"* ]]; then
    echo "$project_patterns_arg must be the first argument in the list\!" >&2;
    return 1;
  fi
  if [[ -n "$MY_WORKPLACE_PROJECT_DIRS" ]]; then
    local proj_dirs=(`echo "$MY_WORKPLACE_PROJECT_DIRS" | xargs`);
  else
    tmuxps_get_project_dirs;
    local proj_dirs=(`echo "$TMUXPS_PROJECT_DIRS" | xargs`);
  fi
  for proj_dir in $proj_dirs[@]; do
    cd "$proj_dir";
    for proj in `find "$proj_dir" -mindepth 1 -maxdepth 1 -type d`; do
      cd "$proj";
      if [[ ! "$proj" =~ "/data$" && `echo "$proj" |  grep -Ei "$project_patterns"` ]]; then
        gfind_files $args | sed -E "s,^./(.*?),`pwd`/\1,g" | sed -E 's,/Users/\w+?/,~/,';
      fi
      cd ..;
    done;
  done;
}

function workplace_find_in_files {
  local project_patterns_arg="--${MY_WORKPLACE_PROJECT_PATTERNS_ARG_NAME:-project_patterns}=";
  local args=($@);
  if [[ "${args}" == "$project_patterns_arg"* ]]; then
    local project_patterns="${args[1]}";
    project_patterns="${project_patterns/"${project_patterns_arg}"/}";
    args=("${args[@]:1}");
  else
    local project_patterns=".*";
  fi
  if [[ "${args[*]}" == *"$project_patterns_arg"* ]]; then
    echo "$project_patterns_arg must be the first argument in the list\!" >&2;
    return 1;
  fi
  if [[ -n "$MY_WORKPLACE_PROJECT_DIRS" ]]; then
    local proj_dirs=(`echo "$MY_WORKPLACE_PROJECT_DIRS" | xargs`);
  else
    tmuxps_get_project_dirs;
    local proj_dirs=(`echo "$TMUXPS_PROJECT_DIRS" | xargs`);
  fi
  for proj_dir in $proj_dirs[@]; do
    cd "$proj_dir";
    for proj in `find "$proj_dir" -mindepth 1 -maxdepth 1 -type d`; do
      cd "$proj";
      if [[ ! "$proj" =~ "/data$" && `echo "$proj" |  grep -Ei "$project_patterns"` ]]; then
        gfind_in_files $args | sed -E "s,^./(.*?),`pwd`/\1,g" | sed -E 's,/Users/\w+?/,~/,';
      fi
      cd ..;
    done;
  done;
}

function workplace_find_items {
  local project_patterns_arg="--${MY_WORKPLACE_PROJECT_PATTERNS_ARG_NAME:-project_patterns}=";
  local args=($@);
  if [[ "${args}" == "$project_patterns_arg"* ]]; then
    local project_patterns="${args[1]}";
    project_patterns="${project_patterns/"${project_patterns_arg}"/}";
    args=("${args[@]:1}");
  else
    local project_patterns=".*";
  fi
  if [[ "${args[*]}" == *"$project_patterns_arg"* ]]; then
    echo "$project_patterns_arg must be the first argument in the list\!" >&2;
    return 1;
  fi
  if [[ -n "$MY_WORKPLACE_PROJECT_DIRS" ]]; then
    local proj_dirs=(`echo "$MY_WORKPLACE_PROJECT_DIRS" | xargs`);
  else
    tmuxps_get_project_dirs;
    local proj_dirs=(`echo "$TMUXPS_PROJECT_DIRS" | xargs`);
  fi
  for proj_dir in $proj_dirs[@]; do
    cd "$proj_dir";
    for proj in `find "$proj_dir" -mindepth 1 -maxdepth 1 -type d`; do
      cd "$proj";
      if [[ ! "$proj" =~ "/data$" && `echo "$proj" |  grep -Ei "$project_patterns"` ]]; then
        gfind_items $args | sed -E "s,^./(.*?),`pwd`/\1,g" | sed -E 's,/Users/\w+?/,~/,';
      fi
      cd ..;
    done;
  done;
}

function workplace_repos_do_thing {
  local project_patterns_arg="--${MY_WORKPLACE_PROJECT_PATTERNS_ARG_NAME:-project_patterns}=";
  local args=($@);
  if [[ "${args}" == "$project_patterns_arg"* ]]; then
    local project_patterns="${args[1]}";
    project_patterns="${project_patterns/"${project_patterns_arg}"/}";
    args=("${args[@]:1}");
  else
    local project_patterns=".*";
  fi
  local repo_operation="${args[@]}";
  if [[ "${args[*]}" == *"$project_patterns_arg"* ]]; then
    echo "$project_patterns_arg must be the first argument in the list\!" >&2;
    return 1;
  fi
  if [[ -n "$MY_WORKPLACE_PROJECT_DIRS" ]]; then
    local proj_dirs=(`echo "$MY_WORKPLACE_PROJECT_DIRS" | xargs`);
  else
    tmuxps_get_project_dirs;
    local proj_dirs=(`echo "$TMUXPS_PROJECT_DIRS" | xargs`);
  fi
  for proj_dir in $proj_dirs[@]; do
    cd "$proj_dir";
    for proj in `find "$proj_dir" -mindepth 1 -maxdepth 1 -type d`; do
      cd "$proj";
      if [[ ! "$proj" =~ "/data$" && `echo "$proj" |  grep -Ei "$project_patterns"` ]]; then
        echo '--------------------------';
        pwd;
        eval "$repo_operation";
      fi
      cd ..;
    done;
  done;
}

function project_operation {
  local proj_op; proj_op="$1";
  [[ -z "$proj_op" ]] && { echo "Must specify proj_op\!" >&2; return 1; }
  local prompt_indicator='#######';
  local press_enter_to='press enter to';
  local og_git_branch; og_git_branch="$(git_current_branch)";
  local dest_branch; dest_branch="$2"; dest_branch="${dest_branch:-"$og_git_branch"}";
  local should_pause; should_pause="$3";
  [[ -z "$should_pause" ]] && {
    echo "$prompt_indicator should_pause after each project has been processed with proj_op? (y/N)";
    read -r should_pause;
  }
  git status >/dev/null 2>&1
  local is_git_repo="$?";
  [[ "$is_git_repo" != "0" ]] && { echo "$(pwd) is not a git repo\!" >&2; return $is_git_repo; }
  git stash push | grep -E 'No local changes to save';
  local wasStashed=$?;
  git_all_the_things 2>/dev/null;
  git checkout "$dest_branch";
  git pull;
  # operation
  eval "$proj_op";
  git checkout "$og_git_branch";
  [[ "$wasStashed" != "0" ]] && { git stash pop; }
  echo "Finished with $(pwd)";
  [[ "$should_pause" == "y" ]] && {
    echo "$prompt_indicator $press_enter_to go to next project $prompt_indicator";
    read -r;
  }
}

function find_and_replace {
  declare -a inputs; inputs=($@);
  local tuple_delimiter="${inputs[1]}";
  inputs=("${inputs[@]:1}")
  local preadd_processing="${inputs[1]}";
  inputs=("${inputs[@]:1}")
  local prompt_indicator='#######';
  local press_enter_to='press enter to';
  local file_pattern="${inputs[1]}";
  inputs=("${inputs[@]:1}")
  local commit_msg="${inputs[1]}";
  inputs=("${inputs[@]:1}")
  local old_new_vals=($inputs[@]);
  local files_to_act_on="";
  for old_new_val in "${old_new_vals[@]}"; do
    local old_val new_val;
    old_val="$(echo "$old_new_val" | sed -E "s/(.*)${tuple_delimiter}(.*)/\\1/")";
    new_val="$(echo "$old_new_val" | sed -E "s/(.*)${tuple_delimiter}(.*)/\\2/")";
    files_to_act_on+=" $(gfind_files "$file_pattern" "$old_val")";
    echo "s/$old_val/$new_val/g";
    echo "$files_to_act_on";
    gfind_in_files_replace "s/$old_val/$new_val/g" "$file_pattern";
  done;
  files_to_act_on="$(echo "$files_to_act_on" | trim)"
  echo "All edited files: $files_to_act_on";
  [[ -n "$files_to_act_on" ]] && {
    eval "$preadd_processing";
    echo "$files_to_act_on" | xargs git add;
  }
  git status;
  echo "$prompt_indicator $press_enter_to continue $prompt_indicator";
  read -r;
  git diff --staged;
  echo "should commit? (y/N)";
  local shouldCommit; read -r shouldCommit;
  [[ "$shouldCommit" == "y" ]] && { git commit -m "$commit_msg"; git push; }
}

