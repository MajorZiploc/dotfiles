#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

git restore ./mock_content/.

@test "check find_files '.*\.py|.*\.fs' 'for' '3' for proper listing of occurrences with a file pattern filter and a max depth search of 3" {
  cd ./mock_content
  function f(){
    find_files '.*\.py|.*\.fs' 'for' '3' | sort -f
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
    find_files_fuzz '.*pa.*' '' '2' | sort -f
  }
  run f
  assert_success
expected="$(cat << EOF
./pandas_data_analytics/docker-compose.yaml
./pandas_data_analytics/Dockerfile
./pandas_data_analytics/Pipfile
./pandas_data_analytics/pyproject.toml
./pandas_data_analytics/README.md
./pandas_data_analytics/setup.py
./prolog_prac/hello_world.pl
./prolog_prac/README.md
EOF
)"
  assert_output "$expected"
  cd ..
}

@test "check find_files_delete '.*\.py' 'df' '3' deletes the proper files" {
  git restore ./mock_content/.
  cd ./mock_content
  run git --no-pager status
  refute_output --regexp "deleted:\s*pandas_data_analytics/setup\.py"
  refute_output --regexp "deleted:\s*pandas_data_analytics/src/pandas_notes\.py"
  run find_files_delete '.*\.py' 'df' '3'
  assert_success
  run git --no-pager status
  assert_output --regexp "deleted:\s*pandas_data_analytics/setup\.py"
  assert_output --regexp "deleted:\s*pandas_data_analytics/src/pandas_notes\.py"
  git restore .
  cd ..
}

@test "check find_files_rename '.*\.py' 's/s/z/g;s/(.*?)(\.py)/\1_squad_goals\2/' 'df' '3' renames the proper files" {
  git restore ./mock_content/.
  cd ./mock_content
  run cat ./pandas_data_analytics/setup.py
  assert_success
  run cat ./pandas_data_analytics/src/pandas_notes.py
  assert_success
  run cat ./pandas_data_analytics/zetup_squad_goals.py
  assert_failure
  run cat ./pandas_data_analytics/src/pandaz_notez_squad_goals.py
  assert_failure
  run find_files_rename '.*\.py' 's/s/z/g;s/(.*?)(\.py)/\1_squad_goals\2/' 'df' '3';
  run cat ./pandas_data_analytics/setup.py
  assert_failure
  run cat ./pandas_data_analytics/src/pandas_notes.py
  assert_failure
  run cat ./pandas_data_analytics/zetup_squad_goals.py
  assert_success
  run cat ./pandas_data_analytics/src/pandaz_notez_squad_goals.py
  assert_success
  run find_files_rename ".*_squad_goals\.py" "s/z/s/g;s/(.*)_squad_goals(.*)/\1\2/" "df" "3";
  run cat ./pandas_data_analytics/setup.py
  assert_success
  run cat ./pandas_data_analytics/src/pandas_notes.py
  assert_success
  run cat ./pandas_data_analytics/zetup_squad_goals.py
  assert_failure
  run cat ./pandas_data_analytics/src/pandaz_notez_squad_goals.py
  assert_failure
  cd ..
}

git restore ./mock_content/.


