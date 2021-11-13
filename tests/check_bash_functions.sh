#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

@test "check _find_git_estimator_ignored_dirs" {
  function f(){
    cd ./mock_content/pandas_data_analytics;
    _find_git_estimator_ignored_dirs | ltrim;
    cd ~-;
  }
  # test searching current dir for a gitignore
  run f
  assert_success
  expected="-not -path '*/mock_content/**/obj/*' -not -path '*/ugly_glob/*' -not -path '*/*.egg-info/*' -not -path '*/*.manifest/*' -not -path '*/*.py[cod]/*' -not -path '*/data_stuff/*' -not -path '*/.Python/*' -not -path '*/.cache/*' -not -path '*/.coverage/*' -not -path '*/.eggs/*' -not -path '*/.fake/*' -not -path '*/.git/*' -not -path '*/.svn/*' -not -path '*/.hypothesis/*' -not -path '*/.ionide/*' -not -path '*/.ipynb_checkpoints/*' -not -path '*/.python-version/*' -not -path '*/.tox/*' -not -path '*/__pycache__/*' -not -path '*/build/*' -not -path '*/data/*' -not -path '*/develop-eggs/*' -not -path '*/dist/*' -not -path '*/docs/_build/*' -not -path '*/downloads/*' -not -path '*/eggs/*' -not -path '*/env/*' -not -path '*/htmlcov/*' -not -path '*/lib/*' -not -path '*/lib64/*' -not -path '*/pandas_data_analytics/wine/data/*' -not -path '*/parts/*' -not -path '*/pwd/*' -not -path '*/rm/*' -not -path '*/-rf/*' -not -path '*/test/area/that/should/not/exist/*' -not -path '*/sdist/*' -not -path '*/target/*' -not -path '*/var/*'";
  assert_output "$expected"
  function f(){
    cd ./mock_content/pandas_data_analytics/src;
    _find_git_estimator_ignored_dirs | ltrim;
    cd ~-;
  }
  # test searching up for a gitignore
  run f
  assert_success
  assert_output "$expected"
}

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
    show_block "Very nice content" "Oh, this section is whatever" "$1";
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

@test "check show_block_line_num_range" {
  function f(){
    show_block_line_num_range 2 6 "$1";
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
More stuff that does not matter

Very nice content coming up
all the lines
go
EOF
`
  assert_output "$expected"
}

@test "check csv_delimiter_check_single_line" {
  function f(){
    csv_delimiter_check_single_line "$1" "$2" | trim;
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
  expected=`cat << EOF
4 2
EOF
`
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
2 2
1 3
1 4
EOF
`;
  assert_output "$expected"
}

