# vim: filetype=bash

parse-bash-function-aliases:
  #!/usr/bin/env bash
  aliases=`cat ./shared/required/home/.bashrc.d/functions* | egrep "function\s*[[:alpha:]]" | sed -E 's/function (\w+).*/\1/;s/([[:alpha:]])[[:alpha:]]+_/\1:/g;s/([[:alpha:]])[[:alpha:]]+/\1/g;s/(.*)/_\1/g;s/(.*)/alias \1/g' | tr -d ":"`;
  function_names=`cat ./shared/required/home/.bashrc.d/functions*.bash | egrep "function\s*[[:alpha:]]" | sed -E 's/function\s*([a-zA-Z0-9_-]+?).*/\1/;s/(.*)/"\1"/g'`;
  paste -d= <(echo "$aliases") <(echo "$function_names");

start-container:
  docker-compose -f .devcontainer/docker-compose.yaml up -d;

stop-container:
  docker-compose -f .devcontainer/docker-compose.yaml stop;

connect-to-container CONTAINER_NAME='devcontainer_home_settings_app_1':
  docker exec -it "{{CONTAINER_NAME}}" /bin/bash;

setup OS='ubuntu20.04':
  ./"setup/{{OS}}/scripts/copy.sh" "111" && . ~/.bash_profile;

run-tests FILE_GLOB='' OS='ubuntu20.04':
  #!/usr/bin/env bash
  file_glob="{{FILE_GLOB}}";
  cd tests;
  just setup "{{OS}}";
  if [[ -z "$file_glob" ]]; then
    ./run_tests.sh;
  else
    ./{{FILE_GLOB}};
  fi

get-all-permissions-to-test-content:
  find ./tests/mock_content -not -path '*/__pycache__/*' -not -path '*/bin/*' -not -path '*/obj/*' -not -path '*/.git/*' -not -path '*/.svn/*' -not -path '*/node_modules/*' -not -path '*/.ionide/*' -not -path '*/.venv/*' -exec sudo chmod +777 "{}" \;

