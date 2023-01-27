# NOTE: Need to set MY_WORKPLACE env var for these scripts
# export MY_WORKPLACE="conservis";
#
# if you want to filter less files out of your search
# export FIND_GIT_DEFAULT_CHILD_GITIGNORE_SEARCH_DEPTH="0";
#
# change project_patterns argument name to avoid clashing with possible searches
# export MY_WORKPLACE_PROJECT_PATTERNS_ARG_NAME="project_patterns";
#
# best to set these env vars in your shell's rc file

function my_workplace_find_files {
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
  local proj_dirs=(~/projects-${MY_WORKPLACE}*/);
  for proj_dir in $proj_dirs[@]; do
    cd "$proj_dir";
    for proj in `find "$proj_dir" -mindepth 1 -maxdepth 1 -type d`; do
      cd "$proj";
      if [[ ! "$proj" =~ "/data$" && `echo "$proj" | egrep -i "$project_patterns"` ]]; then
        gfind_files $args | sed -E "s,^./(.*?),`pwd`/\1,g" | sed -E 's,/Users/\w+?/,~/,';
      fi
      cd ..;
    done;
  done;
}

function my_workplace_find_in_files {
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
  local proj_dirs=(~/projects-${MY_WORKPLACE}*/);
  for proj_dir in $proj_dirs[@]; do
    cd "$proj_dir";
    for proj in `find "$proj_dir" -mindepth 1 -maxdepth 1 -type d`; do
      cd "$proj";
      if [[ ! "$proj" =~ "/data$" && `echo "$proj" | egrep -i "$project_patterns"` ]]; then
        gfind_in_files $args | sed -E "s,^./(.*?),`pwd`/\1,g" | sed -E 's,/Users/\w+?/,~/,';
      fi
      cd ..;
    done;
  done;
}

function my_workplace_find_items {
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
  local proj_dirs=(~/projects-${MY_WORKPLACE}*/);
  for proj_dir in $proj_dirs[@]; do
    cd "$proj_dir";
    for proj in `find "$proj_dir" -mindepth 1 -maxdepth 1 -type d`; do
      cd "$proj";
      if [[ ! "$proj" =~ "/data$" && `echo "$proj" | egrep -i "$project_patterns"` ]]; then
        gfind_items $args | sed -E "s,^./(.*?),`pwd`/\1,g" | sed -E 's,/Users/\w+?/,~/,';
      fi
      cd ..;
    done;
  done;
}

function my_workplace_repos_do_thing {
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
  local proj_dirs=(~/projects-${MY_WORKPLACE}*/);
  for proj_dir in $proj_dirs[@]; do
    cd "$proj_dir";
    for proj in `find "$proj_dir" -mindepth 1 -maxdepth 1 -type d`; do
      cd "$proj";
      if [[ ! "$proj" =~ "/data$" && `echo "$proj" | egrep -i "$project_patterns"` ]]; then
        echo '--------------------------';
        pwd;
        echo "Must specify something to do for each project (manually edit this function)" >&2;
        return 1;
      fi
      cd ..;
    done;
  done;
}


