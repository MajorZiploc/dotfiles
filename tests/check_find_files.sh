#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc 2>/dev/null || true;

git restore ./mock_content/.

@test "check find_files '.*\.py|.*\.fs' 'for' '3' for proper listing of occurrences with a file pattern filter and a max depth search of 3" {
  git restore ./mock_content/.
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
  git restore ./mock_content/.
  cd ./mock_content
  function f(){
    find_files_fuzz '.*pa.*' '' '2' | sort -f
  }
  run f
  assert_success
expected="$(cat << EOF
./pandas_data_analytics/.gitignore
./pandas_data_analytics/docker-compose.yml
./pandas_data_analytics/Dockerfile
./pandas_data_analytics/Pipfile
./pandas_data_analytics/pyproject.toml
./pandas_data_analytics/README.md
./pandas_data_analytics/really you gonna  put   all these spaces in here .py
./pandas_data_analytics/setup.py
./parser_files/basic.json
./parser_files/el_pollo_loco.csv
./parser_files/list.json
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
  function f () {
    find_files_delete_preview '.*\.py' 'df' '3' | sort
  }
  run f
  expected=`cat << EOF
rm './pandas_data_analytics/setup.py' ;
rm './pandas_data_analytics/src/pandas_notes.py' ;
EOF
`;
  assert_success
  assert_output "$expected"
  run find_files_delete '.*\.py' 'df' '3'
  assert_success
  run test -f ./pandas_data_analytics/setup.py
  assert_failure
  run test -f ./pandas_data_analytics/src/pandas_notes.py
  assert_failure
  git restore .
  cd ..
}

@test "check find_files_rename '.*\.py' 's/s/z/g;s/(.*?)(\.py)/\1_squad_goals\2/' 'df' '3' renames the proper files" {
  git restore ./mock_content/.
  cd ./mock_content
  function f () {
    find_files_rename_preview '.*\.py' 's/s/z/g;s/(.*?)(\.py)/\1_squad_goals\2/' 'df' '3' | sort
  }
  run f
  expected=`cat << EOF
mv './pandas_data_analytics/setup.py' './pandas_data_analytics/zetup_squad_goals.py' ;
mv './pandas_data_analytics/src/pandas_notes.py' './pandas_data_analytics/src/pandaz_notez_squad_goals.py' ;
EOF
`;
  assert_success
  assert_output "$expected"
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

@test "check find_files_delete can delete a file with spaces in the name" {
  git restore ./mock_content/.
  cd ./mock_content
  function f () {
    find_files_delete_preview '.*really you.*' '' '5' | sort
  }
  run f
  expected=`cat << EOF
rm './pandas_data_analytics/really you gonna  put   all these spaces in here .py' ;
EOF
`;
  assert_success
  assert_output "$expected"
  run test -f './pandas_data_analytics/really you gonna  put   all these spaces in here .py'
  assert_success
  run find_files_delete '.*really you.*' '' '5'
  assert_success
  assert_output ''
  run test -f './pandas_data_analytics/really you gonna  put   all these spaces in here .py'
  assert_failure
  git restore .
  cd ..
}

@test "check find_files_rename can delete a file with spaces in the name" {
  git restore ./mock_content/.
  cd ./mock_content
  run find_files_rename_preview '.*really you.*' "s/(you)/\1_sun/g" '' '2'
  expected=`cat << EOF
mv './pandas_data_analytics/really you gonna  put   all these spaces in here .py' './pandas_data_analytics/really you_sun gonna  put   all these spaces in here .py' ;
EOF
`;
  assert_success
  assert_output "$expected"
  run test -f './pandas_data_analytics/really you_sun gonna  put   all these spaces in here .py'
  assert_failure
  run test -f './pandas_data_analytics/really you gonna  put   all these spaces in here .py'
  assert_success
  run find_files_rename '.*really you.*' "s/(you)/\1_sun/g" '' '2'
  assert_success
  assert_output ''
  run test -f './pandas_data_analytics/really you_sun gonna  put   all these spaces in here .py'
  assert_success
  run test -f './pandas_data_analytics/really you gonna  put   all these spaces in here .py'
  assert_failure
  git restore .
  rm -f './pandas_data_analytics/really you_sun gonna  put   all these spaces in here .py'
  cd ..
}
