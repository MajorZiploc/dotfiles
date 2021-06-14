#!/bin/bash

# lines that begin with 'not ok' are failed tests
# lines that begin with 'ok' are success tests
./run_tests.sh 2>&1 | tee test_results.txt

