#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "check that sourcing bash files does not place output into terminal" {

IFS= ;
l=(
~/.bash_aliases
~/.bash_env_vars
~/.bash_functions
~/.bashrc
~/.bash_profile
);
for file in ${l[@]};
  do
    run source "$file"
    assert_success
    assert_output ''
  done;
unset IFS;
      

}

