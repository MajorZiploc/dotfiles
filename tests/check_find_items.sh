#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

git restore ./mock_content/.

@test "check find_items '.*\.fs|.*src' '3' for proper listing of occurrences with an item pattern filter and a max depth search of 3" {
  git restore ./mock_content/.
  cd ./mock_content
  function f(){
    find_items '.*\.fs|.*src' '3' | sort -f

  }
  run f
  assert_success
expected="$(cat << EOF
./FslabDataAnalytics/Program.fs
./FslabDataAnalytics/utils/index.fs
./pandas_data_analytics/src
EOF
)"
assert_output "$expected"
  cd ..
}

@test "check find_items_fuzz '.*(b|o).*\.py|.*utils' '5' for proper listing of occurrences with an item pattern filter and a max depth search of 5" {
  git restore ./mock_content/.
  cd ./mock_content
  function f(){
    find_items_fuzz '.*(b|o).*\.py|.*utils' '5' | sort -f
  }
  run f
  assert_success
expected="$(cat << EOF
./FslabDataAnalytics/utils
./pandas_data_analytics/src/body_comp/run.py
./pandas_data_analytics/src/common_food/run.py
./pandas_data_analytics/src/osrs/run.py
./pandas_data_analytics/src/outliers/run.py
./pandas_data_analytics/src/pandas_notes.py
./pandas_data_analytics/src/pokemon_learn_sets/run.py
./pandas_data_analytics/src/utils
EOF
)"
  assert_output "$expected"
  cd ..
}

@test "check find_items_delete '(.*utils.*|.*utils\.py)' '5' deletes the proper items" {
  git restore ./mock_content/.
  cd ./mock_content
  run find_items_delete_preview '(.*utils.*|.*utils\.py)' '5'
  expected=`cat << EOF
NOTE: This behavior may not be the exact behavior when running the command out of preview mode
rm -rf ./FslabDataAnalytics/utils ;
rm -rf ./pandas_data_analytics/src/utils ;
rm -rf ./FslabDataAnalytics/utils/index.fs ;
rm -rf ./pandas_data_analytics/src/text_parser/utils.py ;
rm -rf ./pandas_data_analytics/src/utils/utils.py ;
rm -rf ./pandas_data_analytics/src/utils/__init__.py ;
EOF
`;
  assert_success
  assert_output "$expected"
  run git --no-pager status
  refute_output --regexp "deleted:\s*FslabDataAnalytics/utils/index.fs"
  refute_output --regexp "deleted:\s*pandas_data_analytics/src/text_parser/utils.py"
  refute_output --regexp "deleted:\s*pandas_data_analytics/src/utils/__init__.py"
  refute_output --regexp "deleted:\s*pandas_data_analytics/src/utils/utils.py"
  run find_items_delete '(.*utils.*|.*utils\.py)' '5'
  assert_success
  assert_output ''
  run git --no-pager status
  assert_output --regexp "deleted:\s*FslabDataAnalytics/utils/index.fs"
  assert_output --regexp "deleted:\s*pandas_data_analytics/src/text_parser/utils.py"
  assert_output --regexp "deleted:\s*pandas_data_analytics/src/utils/__init__.py"
  assert_output --regexp "deleted:\s*pandas_data_analytics/src/utils/utils.py"
  git restore .
  cd ..
}

@test "check find_items_rename '(.*utils.*|.*utils\.py)' '5' renames the proper items" {
  git restore ./mock_content/.
  cd ./mock_content
  run find_items_rename_preview '(.*utils.*|.*utils\.py)' "s/(util)/\1_sun/g" '2'
  expected=`cat << EOF
NOTE: This behavior may not be the exact behavior when running the command out of preview mode
mv ./FslabDataAnalytics/utils ./FslabDataAnalytics/util_suns ;
EOF
`;
  assert_success
  assert_output "$expected"
  run git --no-pager status
  refute_output --regexp "deleted:\s*FslabDataAnalytics/utils/index.fs"
  refute_output --regexp "FslabDataAnalytics/util_suns/"
  run find_items_rename '(.*utils.*|.*utils\.py)' "s/(util)/\1_sun/g" '2'
  assert_success
  assert_output ''
  run git --no-pager status
  assert_output --regexp "deleted:\s*FslabDataAnalytics/utils/index.fs"
  assert_output --regexp "FslabDataAnalytics/util_suns/"
  git restore .
  rm -rf ./FslabDataAnalytics/util_suns
  cd ..
}
