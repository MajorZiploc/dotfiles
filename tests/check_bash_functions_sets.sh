#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc 2>/dev/null || true;

@test "check set_is_subset function" {
  cd ./mock_content
  all=`cat << EOF
./pandas_data_analytics/src/pokemon_learn_sets/run.py
./pandas_data_analytics/src/pandas_notes.py
./pandas_data_analytics/src/text_parser/utils.py
./pandas_data_analytics/src/text_parser/run.py
./pandas_data_analytics/src/text_parser/parser.py
./pandas_data_analytics/src/text_parser/__init__.py
./pandas_data_analytics/src/outliers/run.py
./pandas_data_analytics/src/utils/utils.py
./pandas_data_analytics/src/utils/__init__.py
./pandas_data_analytics/src/netflix/run.py
./pandas_data_analytics/src/osrs/run.py
./pandas_data_analytics/src/__init__.py
./pandas_data_analytics/src/common_food/run.py
./pandas_data_analytics/src/body_comp/run.py
./pandas_data_analytics/setup.py
EOF
`
  df=`cat << EOF
./pandas_data_analytics/src/pokemon_learn_sets/run.py
./pandas_data_analytics/src/pandas_notes.py
./pandas_data_analytics/src/text_parser/utils.py
./pandas_data_analytics/src/text_parser/run.py
./pandas_data_analytics/src/outliers/run.py
./pandas_data_analytics/src/utils/utils.py
./pandas_data_analytics/src/netflix/run.py
./pandas_data_analytics/src/osrs/run.py
./pandas_data_analytics/src/common_food/run.py
./pandas_data_analytics/src/body_comp/run.py
./pandas_data_analytics/setup.py
EOF
`
  run set_is_subset <(echo "$df") <(echo "$all")
  assert_success
  assert_output ''
  fs=`cat << EOF
./FslabDataAnalytics/utils/index.fs
./FslabDataAnalytics/Program.fs
./FslabDataAnalytics/FslabDataAnalytics/tut/run.fs
./FslabDataAnalytics/FslabDataAnalytics/osrs/run.fs
EOF
`
  run set_is_subset <(echo "$fs") <(echo "$all")
  assert_failure
  assert_output ''
}

@test "check set_difference function" {
  cd ./mock_content
  all=`cat << EOF
./pandas_data_analytics/src/pokemon_learn_sets/run.py
./pandas_data_analytics/src/pandas_notes.py
./pandas_data_analytics/src/pandas_notes.py
./pandas_data_analytics/src/pandas_notes.py
./pandas_data_analytics/src/pandas_notes.py
./pandas_data_analytics/src/text_parser/utils.py
./pandas_data_analytics/src/text_parser/run.py
./pandas_data_analytics/src/text_parser/parser.py
./pandas_data_analytics/src/text_parser/__init__.py
./pandas_data_analytics/src/outliers/run.py
./pandas_data_analytics/src/utils/utils.py
./pandas_data_analytics/src/utils/__init__.py
./pandas_data_analytics/src/netflix/run.py
./pandas_data_analytics/src/osrs/run.py
./pandas_data_analytics/src/__init__.py
./pandas_data_analytics/src/common_food/run.py
./pandas_data_analytics/src/body_comp/run.py
./pandas_data_analytics/setup.py
EOF
`
  df=`cat << EOF
./pandas_data_analytics/src/pokemon_learn_sets/run.py
./pandas_data_analytics/src/pandas_notes.py
./pandas_data_analytics/src/text_parser/utils.py
./pandas_data_analytics/src/text_parser/run.py
./pandas_data_analytics/src/outliers/run.py
./pandas_data_analytics/src/utils/utils.py
./pandas_data_analytics/src/netflix/run.py
./pandas_data_analytics/src/netflix/run.py
./pandas_data_analytics/src/netflix/run.py
./pandas_data_analytics/src/netflix/run.py
./pandas_data_analytics/src/osrs/run.py
./pandas_data_analytics/src/common_food/run.py
./pandas_data_analytics/src/body_comp/run.py
./pandas_data_analytics/setup.py
EOF
`
  run set_difference <(echo "$all") <(echo "$df")
expected="$(cat << EOF
./pandas_data_analytics/src/__init__.py
./pandas_data_analytics/src/text_parser/__init__.py
./pandas_data_analytics/src/text_parser/parser.py
./pandas_data_analytics/src/utils/__init__.py
EOF
)"
  assert_success
  assert_output "$expected"
  run set_difference <(echo "$all") <(echo "$all")
  assert_success
  assert_output ''
  run set_difference <(echo "$df") <(echo "$all")
  assert_success
  assert_output ''
}

@test "check set_elem function" {
  cd ./mock_content
  all=`cat << EOF
eggs
pancakes
waffles
EOF
  `
  ele="pancakes";
  run set_elem "$ele" <(echo "$all")
  assert_success
  assert_output ''
  all=`cat << EOF
eggs
waffles
EOF
  `
  ele="pancakes";
  run set_elem "$ele" <(echo "$all")
  assert_failure
  assert_output ''
  all=`cat << EOF
eggs
pancakes
waffles
EOF
  `
  ele="pancake";
  run set_elem "$ele" <(echo "$all")
  assert_failure
  assert_output ''
}

@test "check set_cardinality function" {
  cd ./mock_content
  all=`cat << EOF
zoo
eggs
leg
1
2
3 4 5 6
eggs
leg
EOF
  `;
  expected=6;
  function f () {
    set_cardinality <(echo "$all") | trim
  }
  run f
  assert_success
  assert_output "$expected"
}

@test "check set_eq function" {
  cd ./mock_content
  set1=`cat << EOF
zoo
eggs
leg
1
2
3 4 5 6
eggs
leg
EOF
  `;
  set2=`cat << EOF
zoo
zoo
eggs
leg
1
2
3 4 5 6
eggs
leg
EOF
  `;
  set3=`cat << EOF
eggs
leg
1
2
3 4 5 6
eggs
leg
EOF
  `;
  run set_eq <(echo "$set1") <(echo "$set1")
  assert_success
  run set_eq <(echo "$set1") <(echo "$set2")
  assert_success
  run set_eq <(echo "$set1") <(echo "$set3")
  assert_failure
}

@test "check set_union function" {
  cd ./mock_content
  set1=`cat << EOF
zoo
eggs
leg
1
2
3 4 5 6
eggs
leg
EOF
  `;
  set2=`cat << EOF
zoo
zoo
eggs
leg
1
2
3 4 5 6
eggs
leg
EOF
  `;
  expected=`cat << EOF
1
2
3 4 5 6
eggs
leg
zoo
EOF
`
  run set_union <(echo "$set1") <(echo "$set2")
  assert_success
  assert_output "$expected"
  run set_union <(echo "$set1") <(echo "$set1")
  assert_success
  assert_output "$expected"
  set1=`cat << EOF
zoo
eggs
leg
1
2
3 4 5 6
eggs
leg
EOF
  `;
  set2=`cat << EOF
boo
zoo
eggs
true
1
2
3 4 5 6
eggs
leg
EOF
  `;
  expected=`cat << EOF
1
2
3 4 5 6
boo
eggs
leg
true
zoo
EOF
`
  run set_union <(echo "$set1") <(echo "$set2")
  assert_success
  assert_output "$expected"
}

@test "check set_intersection function" {
  cd ./mock_content
  set1=`cat << EOF
zoo
eggs
leg
1
1
1
1
2
3 4 5 6
eggs
leg
EOF
  `;
  set2=`cat << EOF
zoo
zoo
eggs
leg
1
2
3 4 5 6
3 4 5 6
3 4 5 6
3 4 5 6
eggs
leg
EOF
  `;
  expected=`cat << EOF
1
2
3 4 5 6
eggs
leg
zoo
EOF
`
  run set_intersection <(echo "$set1") <(echo "$set2")
  assert_success
  assert_output "$expected"
  run set_intersection <(echo "$set1") <(echo "$set1")
  assert_success
  assert_output "$expected"
  set1=`cat << EOF
eggs
leg
1
2
3 4 5 6
eggs
leg
EOF
  `;
  set2=`cat << EOF
boo
zoo
eggs
true
1
2
3 4 5 6
eggs
leg
EOF
  `;
  expected=`cat << EOF
1
2
3 4 5 6
eggs
leg
EOF
`
  run set_intersection <(echo "$set1") <(echo "$set2")
  assert_success
  assert_output "$expected"
}


@test "check set_symmetric_difference function" {
  cd ./mock_content
  set1=`cat << EOF
zoo
eggs
leg
1
2
3 4 5 6
eggs
leg
EOF
  `;
  set2=`cat << EOF
zoo
zoo
eggs
leg
1
2
3 4 5 6
eggs
leg
EOF
  `;
  expected=`cat << EOF
EOF
`
  run set_symmetric_difference <(echo "$set1") <(echo "$set2")
  assert_success
  assert_output "$expected"
  run set_symmetric_difference <(echo "$set1") <(echo "$set1")
  assert_success
  assert_output "$expected"
  set1=`cat << EOF
eggs
leg
1
2
3 4 5 6
eggs
yo
yo
leg
goo
EOF
  `;
  set2=`cat << EOF
boo
zoo
eggs
true
1
2
3 4 5 6
eggs
leg
EOF
  `;
  expected=`cat << EOF
boo
goo
true
yo
zoo
EOF
`
  run set_symmetric_difference <(echo "$set1") <(echo "$set2")
  assert_success
  assert_output "$expected"
}

@test "check set_minimum function" {
  cd ./mock_content
  set1=`cat << EOF
zoo
eggs
leg
1
2
3 4 5 6
eggs
leg
EOF
  `;
  expected=`cat << EOF
1
EOF
`
  run set_minimum <(echo "$set1")
  assert_success
  assert_output "$expected"
  set1=`cat << EOF
eggs
leg
eggs
leg
goo
EOF
  `;
  expected=`cat << EOF
eggs
EOF
`
  run set_minimum <(echo "$set1")
  assert_success
  assert_output "$expected"
}

@test "check set_minimum_num function" {
  cd ./mock_content
  set1=`cat << EOF
2
1
3 4 5 6
EOF
  `;
  expected=`cat << EOF
1
EOF
`
  run set_minimum_num <(echo "$set1")
  assert_success
  assert_output "$expected"
}

@test "check set_maximum function" {
  cd ./mock_content
  set1=`cat << EOF
zoo
eggs
leg
1
2
3 4 5 6
eggs
leg
EOF
  `;
  expected=`cat << EOF
zoo
EOF
`
  run set_maximum <(echo "$set1")
  assert_success
  assert_output "$expected"
  set1=`cat << EOF
eggs
leg
eggs
leg
goo
EOF
  `;
  expected=`cat << EOF
leg
EOF
`
  run set_maximum <(echo "$set1")
  assert_success
  assert_output "$expected"
}

@test "check set_maximum_num function" {
  cd ./mock_content
  set1=`cat << EOF
2
1
3 4 5 6
EOF
  `;
  expected=`cat << EOF
3 4 5 6
EOF
`
  run set_maximum_num <(echo "$set1")
  assert_success
  assert_output "$expected"
}

@test "check set_are_disjoint function" {
  cd ./mock_content
  all=`cat << EOF
./pandas_data_analytics/src/pokemon_learn_sets/run.py
./pandas_data_analytics/src/pandas_notes.py
./pandas_data_analytics/src/text_parser/utils.py
./pandas_data_analytics/src/text_parser/run.py
./pandas_data_analytics/src/text_parser/parser.py
./pandas_data_analytics/src/text_parser/__init__.py
./pandas_data_analytics/src/outliers/run.py
./pandas_data_analytics/src/utils/utils.py
./pandas_data_analytics/src/utils/__init__.py
./pandas_data_analytics/src/netflix/run.py
./pandas_data_analytics/src/osrs/run.py
./pandas_data_analytics/src/__init__.py
./pandas_data_analytics/src/common_food/run.py
./pandas_data_analytics/src/body_comp/run.py
./pandas_data_analytics/setup.py
EOF
`
  df=`cat << EOF
./pandas_data_analytics/src/pokemon_learn_sets/run.py
./pandas_data_analytics/src/pandas_notes.py
./pandas_data_analytics/src/text_parser/utils.py
./pandas_data_analytics/src/text_parser/run.py
./pandas_data_analytics/src/outliers/run.py
./pandas_data_analytics/src/utils/utils.py
./pandas_data_analytics/src/netflix/run.py
./pandas_data_analytics/src/osrs/run.py
./pandas_data_analytics/src/common_food/run.py
./pandas_data_analytics/src/body_comp/run.py
./pandas_data_analytics/setup.py
EOF
`
  run set_are_disjoint <(echo "$df") <(echo "$all")
  assert_failure
  assert_output ''
  fs=`cat << EOF
./FslabDataAnalytics/utils/index.fs
./FslabDataAnalytics/Program.fs
./FslabDataAnalytics/FslabDataAnalytics/tut/run.fs
./FslabDataAnalytics/FslabDataAnalytics/osrs/run.fs
EOF
`
  run set_are_disjoint <(echo "$fs") <(echo "$all")
  assert_success
  assert_output ''
}

