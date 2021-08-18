#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

@test "check to_winpath" {
  function f(){
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

@test "check to_unixpath" {
  function f(){
    echo "$1" | to_unixpath;
  }
  path='C:\mnt\Users\someone\stuff.txt'
  run f "$path"
  assert_success
  expected='/c/mnt/Users/someone/stuff.txt'
  assert_output "$expected"
  path='\mnt\Users\someone\stuff.txt'
  run f "$path"
  assert_success
  expected='/mnt/Users/someone/stuff.txt'
  assert_output "$expected"
  path='J:\mnt\Users\someone\stuff.txt'
  run f "$path"
  assert_success
  expected='/j/mnt/Users/someone/stuff.txt'
  assert_output "$expected"
  path='Jo:\mnt\Users\someone\stuff.txt'
  run f "$path"
  assert_success
  expected='Jo:/mnt/Users/someone/stuff.txt'
  assert_output "$expected"
}

@test "check show_root_folder" {
  function f(){
    echo "$1" | show_root_folder;
  }
  pathes=`cat << EOF
./pandas_data_analytics/src/pokemon_learn_sets/run.py
./pandas_data_analytics/src/pandas_notes.py
./data_analytics/src/text_parser/utils.py
./_data_analytics/src/text_parser/run.py
./.data_analytics/src/text_parser/parser.py
./stuff/src/text_parser/__init__.py
./.ya.ya.ya/src/outliers/run.py
./pandas_data_analytics/src/utils/utils.py
pandas_data_analytics/src/utils/utils.py
/c/src/utils/utils.py
C:/src/utils/utils.py
EOF
  `
  run f "$pathes"
  assert_success
  expected=`cat << EOF
pandas_data_analytics
pandas_data_analytics
data_analytics
_data_analytics
.data_analytics
stuff
.ya.ya.ya
pandas_data_analytics
pandas_data_analytics/src/utils/utils.py
/c/src/utils/utils.py
C:/src/utils/utils.py
EOF
  `
  assert_output "$expected"
}

@test "check rev_chars" {
  function f(){
    echo "$1" | rev_chars;
  }
  chars='asdf fdsa'
  run f "$chars"
  assert_success
  expected='asdf fdsa'
  assert_output "$expected"
  chars=''
  run f "$chars"
  assert_success
  expected=''
  assert_output "$expected"
}

@test "check rev_lines" {
  function f(){
    echo "$1" | rev_lines;
  }
  lines=`cat << EOF
1
2
3

4

EOF
  `
  run f "$lines"
  assert_success
  expected=`cat << EOF
4

3
2
1
EOF
`
  assert_output "$expected"
  lines=''
  run f "$lines"
  assert_success
  expected=''
  assert_output "$expected"
}

@test "check toggle_case" {
  function f(){
    echo "$1" | toggle_case;
  }
  chars='asdf FDS1A 2a'
  run f "$chars"
  assert_success
  expected='ASDF fds1a 2A'
  assert_output "$expected"
  chars=''
  run f "$chars"
  assert_success
  expected=''
  assert_output "$expected"
}
