# NOTE: Need to set MY_WORKPLACE env var for these scripts
export MY_WORKPLACE="";
# uncomment if you want to filter less files out of your search
export FIND_GIT_DEFAULT_CHILD_GITIGNORE_SEARCH_DEPTH="0";

function my_workplace_find_files {
  proj_dirs=(~/projects-${MY_WORKPLACE}*/);
  for proj_dir in $proj_dirs[@]; do
    cd "$proj_dir";
    for proj in `find "$proj_dir" -mindepth 1 -maxdepth 1 -type d`; do
      cd "$proj";
      if [[ ! "$proj" =~ "/data$" ]]; then
        gfind_files $@ | sed -E "s,^./(.*?),`pwd`/\1,g" | sed -E 's,/Users/\w+?/,~/,';
      fi
      cd ..;
    done;
  done;
}

function my_workplace_find_in_files {
  proj_dirs=(~/projects-${MY_WORKPLACE}*/);
  for proj_dir in $proj_dirs[@]; do
    cd "$proj_dir";
    for proj in `find "$proj_dir" -mindepth 1 -maxdepth 1 -type d`; do
      cd "$proj";
      if [[ ! "$proj" =~ "/data$" ]]; then
        gfind_in_files $@ | sed -E "s,^./(.*?),`pwd`/\1,g" | sed -E 's,/Users/\w+?/,~/,';
      fi
      cd ..;
    done;
  done;
}

function my_workplace_find_items {
  proj_dirs=(~/projects-${MY_WORKPLACE}*/);
  for proj_dir in $proj_dirs[@]; do
    cd "$proj_dir";
    for proj in `find "$proj_dir" -mindepth 1 -maxdepth 1 -type d`; do
      cd "$proj";
      if [[ ! "$proj" =~ "/data$" ]]; then
        gfind_items $@ | sed -E "s,^./(.*?),`pwd`/\1,g" | sed -E 's,/Users/\w+?/,~/,';
      fi
      cd ..;
    done;
  done;
}

function my_workplace_repos_do_thing {
  proj_dirs=(~/projects-${MY_WORKPLACE}*/);
  for proj_dir in $proj_dirs[@]; do
    cd "$proj_dir";
    for proj in `find "$proj_dir" -mindepth 1 -maxdepth 1 -type d`; do
      cd "$proj";
      echo '--------------------------';
      pwd;
      echo "Must specify something to do for each project (manually edit this function)" >&2;
      echo '--------------------------';
      return 1;
      cd ..;
    done;
  done;
}

