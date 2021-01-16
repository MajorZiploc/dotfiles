#!/bin/bash

# defaults:
# -d|--directory) 
#   .
# -f|--from)
#   space
# -t|--to
#   empty_string

# rn_selected --directory . --from camel --to snake
# rn_selected --directory . --from kebab --to snake
# rn_selected --directory . --from space --to snake
# rn_selected --directory . --from space (--to empty_string)

for f in *
do
  echo "$f"
done