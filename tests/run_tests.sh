#!/bin/bash

./check_*.sh

# more verbose, but doesn't collect the counts of all tests into 1 count. like the above.
# for test in check_*.sh;
#   do
#     echo "---------------"
#     echo "## Running Test Cases: $test"
#     echo ""
#     ./"$test";
#     echo "---------------"
#     echo ""
# done;

