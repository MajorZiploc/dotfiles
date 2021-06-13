#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

@test "check find_files '.*\.py|.*\.fs' 'for' '3' for proper listing of occurrences with a file pattern filter and a max depth search of 3" {
  cd ./mock_content
  function f(){
    find_files '.*\.py|.*\.fs' 'for' '3' | sort
  }
  run f
  assert_success
expected="$(cat << EOF
./FslabDataAnalytics/utils/index.fs
./pandas_data_analytics/src/pandas_notes.py
EOF
)"
assert_output "$expected"
  cd ..
}

@test "check find_files_fuzz '.*pa.*' '' '2' for proper listing of occurrences with a file pattern filter and a max depth search of 2" {
  cd ./mock_content
  function f(){
    find_files_fuzz '.*pa.*' '' '2' | sort
  }
  run f
  assert_success
expected="$(cat << EOF
./pandas_data_analytics/Dockerfile
./pandas_data_analytics/Pipfile
./pandas_data_analytics/README.md
./pandas_data_analytics/docker-compose.yaml
./pandas_data_analytics/pyproject.toml
./pandas_data_analytics/setup.py
./prolog_prac/README.md
./prolog_prac/hello_world.pl
EOF
)"
  assert_output "$expected"
  cd ..
}

