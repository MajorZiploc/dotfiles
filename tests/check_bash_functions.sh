#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

@test "check show_line_nums" {
  function f(){
    show_line_nums <(echo "$1");
  }
  content=`cat << EOF
all the lines
go
hey!!

ohhh
EOF
`
  run f "$content"
  assert_success
  expected=`cat << EOF
1 all the lines
2 go
3 hey!!
4 
5 ohhh
EOF
`
  assert_output "$expected"
}

@test "check show_block" {
  function f(){
    show_block "Very nice content" "Oh, this section is whatever" <(echo "$1");
  }
  content=`cat << EOF
Pre information
More stuff that does not matter

Very nice content coming up
all the lines
go
hey!!

ohhh

Oh, this section is whatever
more stuff
hmmmmmm
EOF
`
  run f "$content"
  assert_success
  expected=`cat << EOF
Very nice content coming up
all the lines
go
hey!!

ohhh

Oh, this section is whatever
EOF
`
  assert_output "$expected"
}

@test "check csv_delimiter_check_single_line" {
  function f(){
    csv_delimiter_check_single_line "$1" "$2"
  }
  content=`cat << EOF
id,name,descr
1,bike,blue
2,car,red
3,plane,yellow
EOF
`
  run f "$content"
  assert_success
  expected="2"
  assert_output "$expected"
  content=`cat << EOF
id*name*descr
1*bike*blue**
2*car*red
3*plane*yellow*
EOF
`
  run f "$content" "*"
  assert_success
  expected=`cat << EOF
2
3
4
EOF
`;
  assert_output "$expected"
}

