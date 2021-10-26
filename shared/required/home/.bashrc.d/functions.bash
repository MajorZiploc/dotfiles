function search_env_for {
  # searches through bash env and user defined bash tools
  local search_regex="$1";
  search_regex=${search_regex:-".*"};
  cat <(ls -A ~/bin 2> /dev/null) <(ls -A /usr/local/bin 2> /dev/null) <(alias) <(env) <(declare -F) <(shopt) | egrep -i "$search_regex";
}

function search_env_for_fuzz {
  # fuzzy searches through bash env and user defined bash tools
  local search_regex="$1";
  search_regex=${search_regex:+"$(echo "$search_regex" | to_fuzz)"};
  search_env_for "$search_regex";
}

function show_cmds_like {
  local pattern="$1";
  [[ -z "$pattern" ]] && { echo "Must specify a command pattern!" >&2; return 1; }
  local search_res=$(search_env_for "$pattern");
  local alias=`echo "$search_res" | egrep -i "\s*alias"`;
  [[ -z "$alias" ]] || { echo "$alias"; }
  local fn_names=$(echo "$search_res" | egrep -i "\s*declare -f" | sed -E "s/declare -f (.*)/\1/" | xargs);
  for fn_name in ${fn_names[@]}; do
    echo "$(declare -f $fn_name)";
  done;
}

function show_cmds_like_fuzz {
  local pattern="$1";
  [[ -z "$pattern" ]] && { echo "Must specify a command pattern!" >&2; return 1; }
  pattern=`echo "$pattern" | to_fuzz`;
  show_cmds_like "$pattern";
}

