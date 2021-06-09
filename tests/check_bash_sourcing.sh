#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "check that sourcing ~/.bash_aliases does not place output into terminal" {
  run source ~/.bash_aliases
  assert_success
  assert_output ''
}

@test "check that sourcing ~/.bash_env_vars does not place output into terminal" {
  run source ~/.bash_env_vars
  assert_success
  assert_output ''
}

@test "check that sourcing ~/.bash_functions does not place output into terminal" {
  run source ~/.bash_functions
  assert_success
  assert_output ''
}

@test "check that sourcing ~/.bashrc does not place output into terminal" {
  run source ~/.bashrc
  assert_success
  assert_output ''
}

@test "check that sourcing ~/.bash_profile does not place output into terminal" {
  run source ~/.bash_profile
  assert_success
  assert_output ''
}

