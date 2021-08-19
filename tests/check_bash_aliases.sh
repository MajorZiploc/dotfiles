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

@test "check camel_to_snake" {
  function f(){
    echo "$1" | camel_to_snake;
  }
  chars='myVar yourVar'
  run f "$chars"
  assert_success
  expected='my_var your_var'
  assert_output "$expected"
  chars=''
  run f "$chars"
  assert_success
  expected=''
  assert_output "$expected"
}

@test "check snake_to_camel" {
  function f(){
    echo "$1" | snake_to_camel;
  }
  chars='my_var your_var'
  run f "$chars"
  assert_success
  expected='myVar yourVar'
  assert_output "$expected"
  chars=''
  run f "$chars"
  assert_success
  expected=''
  assert_output "$expected"
}

@test "check snake_to_space" {
  function f(){
    echo "$1" | snake_to_space;
  }
  chars='my_var your_var'
  run f "$chars"
  assert_success
  expected='my var your var'
  assert_output "$expected"
  chars=''
  run f "$chars"
  assert_success
  expected=''
  assert_output "$expected"
}

@test "check camel_to_space" {
  function f(){
    echo "$1" | camel_to_space;
  }
  chars='myVar yourVar'
  run f "$chars"
  assert_success
  expected='my Var your Var'
  assert_output "$expected"
  chars=''
  run f "$chars"
  assert_success
  expected=''
  assert_output "$expected"
}

@test "check space_to_snake" {
  function f(){
    echo "$1" | space_to_snake;
  }
  lines=`cat << EOF
my var
your var
EOF
`
  run f "$lines"
  assert_success
  expected=`cat << EOF
my_var
your_var
EOF
`
  assert_output "$expected"
  lines=''
  run f "$lines"
  assert_success
  expected=''
  assert_output "$expected"
}

@test "check space_to_camel" {
  function f(){
    echo "$1" | space_to_camel;
  }
  lines=`cat << EOF
my var
your var
EOF
`
  run f "$lines"
  assert_success
  expected=`cat << EOF
myVar
yourVar
EOF
`
  assert_output "$expected"
  lines=''
  run f "$lines"
  assert_success
  expected=''
  assert_output "$expected"
}

@test "check to_lower" {
  function f(){
    echo "$1" | to_lower;
  }
  lines=`cat << EOF
MY VAR1
your var
EOF
`
  run f "$lines"
  assert_success
  expected=`cat << EOF
my var1
your var
EOF
`
  assert_output "$expected"
  lines=''
  run f "$lines"
  assert_success
  expected=''
  assert_output "$expected"
}

@test "check to_upper" {
  function f(){
    echo "$1" | to_upper;
  }
  lines=`cat << EOF
MY VAR1
your var
EOF
`
  run f "$lines"
  assert_success
  expected=`cat << EOF
MY VAR1
YOUR VAR
EOF
`
  assert_output "$expected"
  lines=''
  run f "$lines"
  assert_success
  expected=''
  assert_output "$expected"
}

@test "check keep_last" {
  function f(){
    echo "$1" | keep_last;
  }
  lines=`cat << EOF
MY VAR1
a
your var
your var
MY VAR1
a
EOF
`
  run f "$lines"
  assert_success
  expected=`cat << EOF
your var
MY VAR1
a
EOF
`
  assert_output "$expected"
  lines=''
  run f "$lines"
  assert_success
  expected=''
  assert_output "$expected"
}

@test "check keep_first" {
  function f(){
    echo "$1" | keep_first;
  }
  lines=`cat << EOF
MY VAR1
a
your var
your var
MY VAR1
a
EOF
`
  run f "$lines"
  assert_success
  expected=`cat << EOF
MY VAR1
a
your var
EOF
`
  assert_output "$expected"
  lines=''
  run f "$lines"
  assert_success
  expected=''
  assert_output "$expected"
}

@test "check bash_surround_expression" {
  function f(){
    echo "$1" | bse;
  }
  lines=`cat << EOF
echo "\$eles"
a phrase is here
EOF
`
  run f "$lines"
  assert_success
  expected=`cat << EOF
"\$\(echo "\$eles"\)"
"\$\(a phrase is here\)"
EOF
`
  expected=`echo "$expected" | tr -d '\'`
  assert_output "$expected"
  lines=''
  run f "$lines"
  assert_success
  expected=''
  assert_output "$expected"
}

@test "check bash_surround_stream" {
  function f(){
    echo "$1" | bss;
  }
  lines=`cat << EOF
echo "\$eles"
a phrase is here
EOF
`
  run f "$lines"
  assert_success
  expected=`cat << EOF
<\(echo "\$eles"\)
<\(a phrase is here\)
EOF
`
  expected=`echo "$expected" | tr -d '\'`
  assert_output "$expected"
  lines=''
  run f "$lines"
  assert_success
  expected=''
  assert_output "$expected"
}

@test "check bash_surround_stream_echo" {
  function f(){
    echo "$1" | bsse;
  }
  lines=`cat << EOF
eles
a phrase is here
EOF
`
  run f "$lines"
  assert_success
  expected=`cat << EOF
<\(echo "eles"\)
<\(echo "a phrase is here"\)
EOF
`
  expected=`echo "$expected" | tr -d '\'`
  assert_output "$expected"
  lines=''
  run f "$lines"
  assert_success
  expected=''
  assert_output "$expected"
}

