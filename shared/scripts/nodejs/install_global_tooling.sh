#!/usr/bin/env bash

. ~/.bashrc;
npm install --global trash-cli prettier concurrently gnomon;
# trash-cli: safer rm, moves things to the trash rather than perm delete
# prettier: code formatter
# concurrently: run multiple simple commands or any kind of bash scripts at the same time
#   useful for running multiple commands that hang a terminal at the same time with only needed 1 terminal window doing the work
# gnomon: useful for timing an operation and deltas between prints in that operation
