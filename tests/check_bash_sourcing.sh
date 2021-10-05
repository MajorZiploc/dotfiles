#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "check that sourcing ~/.bashrc.d/portable/aliases.bash does not place output into terminal" {
  run source ~/.bashrc.d/portable/aliases.bash
  # assert_success
  assert_output ''
}

@test "check that sourcing ~/.bashrc.d/portable/env_vars.bash does not place output into terminal" {
  run source ~/.bashrc.d/portable/env_vars.bash
  assert_success
  assert_output ''
}

@test "check that sourcing ~/.bashrc.d/portable/functions.bash does not place output into terminal" {
  run source ~/.bashrc.d/portable/functions.bash
  assert_success
  assert_output ''
}

@test "check that sourcing ~/.bashrc.d/portable/functions_sets.bash does not place output into terminal" {
  run source ~/.bashrc.d/portable/functions.bash
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

