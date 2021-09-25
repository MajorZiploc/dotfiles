#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

@test "check convert_csv_to_json of a csv string" {
  file="./mock_content/parser_files/el_pollo_loco.csv";
  function f(){
    csv=`cat "$1"`;
    convert_csv_to_json "$csv" "$2";
  }
  run f "$file" ","
  expected=`cat << EOF
  {
    "web-scraper-order": "1608223798-253",
    "web-scraper-start-url": "https://www.elpolloloco.com/our-food/",
    "main_food_link": "Chicken Meals",
    "main_food_link-href": "https://www.elpolloloco.com/our-food/individual-chicken",
    "name": "Fire-Grilled Chicken Thigh",
    "serving_size": "3.1 oz",
    "calories": "210",
    "fat": "15g",
    "protein": "21g",
    "carbs": "0g"
  },
EOF
`;

  assert_success
  assert_output --partial "$expected"
}

@test "check convert_csv_to_json of a csv file" {
  file="./mock_content/parser_files/el_pollo_loco.csv";
  function f(){
    csv="$1";
    convert_csv_to_json "$csv" "$2" "$3";
  }
  run f "$file"
  expected=`cat << EOF
  {
    "web-scraper-order": "1608223798-253",
    "web-scraper-start-url": "https://www.elpolloloco.com/our-food/",
    "main_food_link": "Chicken Meals",
    "main_food_link-href": "https://www.elpolloloco.com/our-food/individual-chicken",
    "name": "Fire-Grilled Chicken Thigh",
    "serving_size": "3.1 oz",
    "calories": "210",
    "fat": "15g",
    "protein": "21g",
    "carbs": "0g"
  },
EOF
`
  assert_success
  assert_output --partial "$expected"
}
