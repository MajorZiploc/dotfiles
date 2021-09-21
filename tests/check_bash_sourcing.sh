#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "check that sourcing ~/.bashrc.d/aliases.bash does not place output into terminal" {
  run source ~/.bashrc.d/aliases.bash
  # assert_success
  assert_output ''
}

@test "check that sourcing ~/.bashrc.d/env_vars.bash does not place output into terminal" {
  run source ~/.bashrc.d/env_vars.bash
  assert_success
  assert_output ''
}

@test "check that sourcing ~/.bashrc.d/functions.bash does not place output into terminal" {
  run source ~/.bashrc.d/functions.bash
  assert_success
  assert_output ''
}

@test "check that sourcing ~/.bashrc does not place output into terminal" {
  run source ~/.bashrc
  # assert_success
  assert_output ''
}

@test "check that sourcing ~/.bash_profile does not place output into terminal" {
  run source ~/.bash_profile
  assert_success
  assert_output ''
}

