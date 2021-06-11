#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

@test "check find_files '.*\.py|.*\.fs' 'for' '3' for proper listing of occurrences with a file pattern filter and a max depth search of 3" {
  cd ./mock_content
  run find_files '.*\.py|.*\.fs' 'for' '3'
  assert_success
expected="$(cat << EOF
./pandas_data_analytics/src/pandas_notes.py
./FslabDataAnalytics/utils/index.fs
EOF
)"
  assert_output "$expected"
  cd ..
}

