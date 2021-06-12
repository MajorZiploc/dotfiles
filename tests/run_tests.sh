#!/bin/bash

tests=(
"check_bash_sourcing.sh"
"check_for_special_bash_fns.sh"
"check_find_in_files.sh"
"check_find_files.sh"
)

for test in ${tests[@]};
  do
    echo "---------------"
    echo "Running $test"
    echo ""
    ./"$test";
    echo "---------------"
    echo ""
done;

