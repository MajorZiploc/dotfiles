#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'
source ~/.bashrc;

function typea_check(){
  type -a "$1";
}

@test "check for find_files" {
  run typea_check "find_files"
  assert_success
  assert_output --partial "find_files"
}

