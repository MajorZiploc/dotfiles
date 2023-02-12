#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc 2>/dev/null || true;

@test "check parse_json_fields of basic (nonlist) json string" {
  file="./mock_content/parser_files/basic.json";
  function f(){
    json=`cat "$1"`;
    parse_json_fields "$json" "$2" "$3" "$4";
  }
  run f "$file" "x" ","
  expected=`cat << EOF
x
1
EOF
`
  assert_success
  assert_output "$expected"
  run f "$file" "x,y_you" ","
  expected=`cat << EOF
x,y_you
1,be looking at me!
EOF
`
  assert_success
  assert_output "$expected"
  run f "$file" "x,y_you" " <:> "
  expected=`cat << EOF
x <:> y_you
1 <:> be looking at me!
EOF
`
  assert_success
  assert_output "$expected"
}

@test "check parse_json_fields of list json string" {
  file="./mock_content/parser_files/list.json";
  function f(){
    json=`cat "$1"`;
    parse_json_fields "$json" "$2" "$3" "$4";
  }
  run f "$file" "x" "," "| ? { \$_.x -gt 1; }"
  expected=`cat << EOF
x
2
EOF
`
  assert_success
  assert_output "$expected"
  run f "$file" "x,y_you" ","
  expected=`cat << EOF
x,y_you
1,be looking at me!
2,44.5
EOF
`
  assert_success
  assert_output "$expected"
  run f "$file" "x,y_you" " <:> "
  expected=`cat << EOF
x <:> y_you
1 <:> be looking at me!
2 <:> 44.5
EOF
`
  assert_success
  assert_output "$expected"
}

@test "check parse_csv_fields of a csv string" {
  file="./mock_content/parser_files/el_pollo_loco.csv";
  function f(){
    csv=`cat "$1"`;
    parse_csv_fields "$csv" "$2" "$3" "$4";
  }
  run f "$file" "fat" ","
  expected=`cat << EOF
fat

15g
3.5g


42g
17g
27g

EOF
`
  assert_success
  assert_output "$expected"
  run f "$file" "fat,calories" ","
  expected=`cat << EOF
fat,calories
,
15g,210
3.5g,140
,
,
42g,910
17g,290
27g,850
,
EOF
`
  assert_success
  assert_output "$expected"
  run f "$file" "fat,calories" " <:> "
  expected=`cat << EOF
fat <:> calories
 <:> 
15g <:> 210
3.5g <:> 140
 <:> 
 <:> 
42g <:> 910
17g <:> 290
27g <:> 850
 <:> 
EOF
`
  assert_success
  assert_output "$expected"
}

@test "check parse_json_fields of basic (nonlist) json file" {
  file="./mock_content/parser_files/basic.json";
  function f(){
    json="$1";
    parse_json_fields "$json" "$2" "$3" "$4";
  }
  run f "$file" "x" ","
  expected=`cat << EOF
x
1
EOF
`
  assert_success
  assert_output "$expected"
  run f "$file" "x,y_you" ","
  expected=`cat << EOF
x,y_you
1,be looking at me!
EOF
`
  assert_success
  assert_output "$expected"
  run f "$file" "x,y_you" " <:> "
  expected=`cat << EOF
x <:> y_you
1 <:> be looking at me!
EOF
`
  assert_success
  assert_output "$expected"
}

@test "check parse_json_fields of list json file" {
  file="./mock_content/parser_files/list.json";
  function f(){
    json="$1";
    parse_json_fields "$json" "$2" "$3" "$4";
  }
  run f "$file" "x" ","
  expected=`cat << EOF
x
1
2
EOF
`
  assert_success
  assert_output "$expected"
  run f "$file" "x,y_you" ","
  expected=`cat << EOF
x,y_you
1,be looking at me!
2,44.5
EOF
`
  assert_success
  assert_output "$expected"
  run f "$file" "x,y_you" " <:> "
  expected=`cat << EOF
x <:> y_you
1 <:> be looking at me!
2 <:> 44.5
EOF
`
  assert_success
  assert_output "$expected"
}

@test "check parse_csv_fields of a csv file" {
  file="./mock_content/parser_files/el_pollo_loco.csv";
  function f(){
    csv="$1";
    parse_csv_fields "$csv" "$2" "$3" "$4";
  }
  run f "$file" "fat" ","
  expected=`cat << EOF
fat

15g
3.5g


42g
17g
27g

EOF
`
  assert_success
  assert_output "$expected"
  run f "$file" "fat,calories" "," "| ? { \$_.fat }"
  expected=`cat << EOF
fat,calories
15g,210
3.5g,140
42g,910
17g,290
27g,850
EOF
`
  assert_success
  assert_output "$expected"
  run f "$file" "fat,calories" " <:> "
  expected=`cat << EOF
fat <:> calories
 <:> 
15g <:> 210
3.5g <:> 140
 <:> 
 <:> 
42g <:> 910
17g <:> 290
27g <:> 850
 <:> 
EOF
`
  assert_success
  assert_output "$expected"
}
