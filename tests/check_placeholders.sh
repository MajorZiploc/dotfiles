#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

@test "check home content to make sure _PLACEHOLDER doesnt exist in the files" {
files=(
  "$HOME/.bash_profile"
  "$HOME/.bashrc"
  "$HOME/.bash_env_vars"
  "$HOME/.bash_functions"
)
for file in ${files[@]};
  do
    
    run grep "_PLACEHOLDER" "$file";
    assert_failure
    assert_output ""
  done;

}

