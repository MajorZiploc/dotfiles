#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

@test "check that to_winpath" { function f(){
    echo "$1" | to_winpath;
  }
  path='/c/mnt/Users/someone/stuff.txt'
  run f "$path"
  assert_success
  expected='C:\mnt\Users\someone\stuff.txt'
  assert_output "$expected"
  path='/mnt/Users/someone/stuff.txt'
  run f "$path"
  assert_success
  expected='\mnt\Users\someone\stuff.txt'
  assert_output "$expected"
  path='/j/mnt/Users/someone/stuff.txt'
  run f "$path"
  assert_success
  expected='J:\mnt\Users\someone\stuff.txt'
  assert_output "$expected"
}

