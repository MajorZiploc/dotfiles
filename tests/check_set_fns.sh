#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;
source ~/.bash_set_functions || true;

@test "check set_is_subset function" {
  cd ./mock_content
  all=`find_files ".*\.py"`;
  df=`find_files ".*\.py" "df"`;
  run set_is_subset <(echo "$df") <(echo "$all")
  assert_success
  assert_output ''
  all=`find_files ".*\.py"`;
  fs=`find_files ".*\.fs"`;
  run set_is_subset <(echo "$fs") <(echo "$all")
  assert_failure
  assert_output ''
}

@test "check set_complement function" {
  cd ./mock_content
  all=`find_files ".*\.py"`;
  df=`find_files ".*\.py" "df"`;
  run set_complement <(echo "$all") <(echo "$df")
expected="$(cat << EOF
./pandas_data_analytics/src/__init__.py
./pandas_data_analytics/src/text_parser/__init__.py
./pandas_data_analytics/src/text_parser/parser.py
./pandas_data_analytics/src/utils/__init__.py
EOF
)"
  assert_success
  assert_output "$expected"
  run set_complement <(echo "$all") <(echo "$all")
  assert_success
  assert_output ''
  run set_complement <(echo "$df") <(echo "$all")
  assert_success
  assert_output ''
}

