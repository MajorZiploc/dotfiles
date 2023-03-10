export JUST_PROJECT_ROOT="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

function just_parse_bash_Punction_aliases {
  local aliases; aliases=`cat "$JUST_PROJECT_ROOT"/shared/required/home/.bashrc.d/functions* | grep -E "function\s*[[:alpha:]]" | sed -E 's/function (\w+).*/\1/;s/([[:alpha:]])[[:alpha:]]+_/\1:/g;s/([[:alpha:]])[[:alpha:]]+/\1/g;s/(.*)/_\1/g;s/(.*)/alias \1/g' | tr -d ":"`;
  local function_names; function_names=`cat "$JUST_PROJECT_ROOT"/shared/required/home/.bashrc.d/functions*.bash | grep -E "function\s*[[:alpha:]]" | sed -E 's/function\s*([a-zA-Z0-9_-]+?).*/\1/;s/(.*)/"\1"/g'`;
  paste -d= <(echo "$aliases") <(echo "$function_names");
}

function just_docker_container_start {
  docker-compose -f "$JUST_PROJECT_ROOT/docker-compose.yaml" up -d;
}

function just_docker_container_stop {
  docker-compose -f "$JUST_PROJECT_ROOT/docker-compose.yaml" stop;
}

function just_docker_container_connect {
  local container_name; container_name="$1";
  container_name="${container_name:-"devcontainer_home_settings_app_1"}";
  docker exec -it "$container_name" /bin/bash;
}
function just_setup {
  local os; os="$1";
  os="${os:-"ubuntu"}";
  "$JUST_PROJECT_ROOT/setup/${os}/scripts/copy.sh" "111" && . ~/.bash_profile;
}

function just_run_tests {
  local file_glob; file_glob="$1";
  local os; os="$2";
  os="${os:-"ubuntu"}";
  cd "$JUST_PROJECT_ROOT/tests" || return 1;
  just_setup "$os";
  if [[ -z "$file_glob" ]]; then
    "./run_tests.sh";
  else
    "./$file_glob";
  fi
  cd ~- || return 1;
}

function just_get_all_permissions_to_test_content {
  find "$JUST_PROJECT_ROOT"/tests/mock_content -not -path '*/__pycache__/*' -not -path '*/bin/*' -not -path '*/obj/*' -not -path '*/.git/*' -not -path '*/.svn/*' -not -path '*/node_modules/*' -not -path '*/.ionide/*' -not -path '*/.venv/*' -exec sudo chmod 777 "{}" \;
}

