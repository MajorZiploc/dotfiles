function search_env_for {
  # searches through bash env and user defined bash tools
  local search_regex="$1";
  search_regex=${search_regex:-".*"};
  cat <(ls -A ~/bin 2> /dev/null) <(ls -A /usr/local/bin 2> /dev/null) <(alias) <(env) <(declare -F) <(shopt) |  grep -Ei "$search_regex";
}

function show_cmds_like {
  local pattern="$1";
  [[ -z "$pattern" ]] && { echo "Must specify a command pattern" >&2; return 1; }
  local search_res=$(search_env_for "$pattern");
  local alias=`echo "$search_res" |  grep -Ei "\s*alias"`;
  [[ -z "$alias" ]] || { echo "$alias"; }
  local fn_names=$(echo "$search_res" |  grep -Ei "\s*declare -f" | sed -E "s/declare -f (.*)/\1/" | xargs);
  for fn_name in ${fn_names[@]}; do
    echo "$(declare -f $fn_name)";
  done;
}

function refresh_settings {
  local flags="$1";
  [[ -z "$flags" ]] && { flags="000"; }
  local project_root_path="$HOME/projects/dotfiles";
  cd "$project_root_path" &&
  git checkout master &&
  echo 'Previous commit information:' &&
  echo "$(git show --summary)" &&
  git pull origin master &&
  "$project_root_path"/setup/OS_PLACEHOLDER/scripts/copy.sh "$flags" &&
  . ~/.bash_profile &&
  echo 'Refreshed settings!' &&
  echo '' &&
  echo 'Current commit information:' &&
  echo "$(git show --summary)";
  echo '';
  cd ~-;
}

