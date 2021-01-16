#!/bin/bash

# TODO: add the following flags:
# -v|--verbose)
# shows the renames that occur
# --preview)
# does not do the renaming. For debugging and seeing if you are doing the right renames

# defaults:
# -d|--directory) 
#   .
# -f|--from)
#   space
# -t|--to
#   underscore

# Default values
directory=*
from="space"
to="underscore"
to_from_choices=("space", "underscore")
verbose=false
preview=false

while [[ $# > 0 ]]
do
  case "$1" in

    -d|--directory)
      directory="$2"
      shift
      ;;

    -f|--from)
      from="$2"
      shift
      ;;

    -t|--to)
      to="$2"
      shift
      ;;

    -v|--verbose)
      verbose=true
      shift
      ;;

    --preview)
      verbose=true
      preview=true
      shift
      ;;

    -h|--help)
      echo "Usage:"
      echo "    -d|--directory
      The directory to rename folders and files in. Non-recursive. Default is: '$directory'
      For all nonhidden files/folders, use -d '*'
      For all hidden files/folders, use -d '* .[^.]*'
      For all files/folders, use -d '.[^.]*'
      "
      echo "    -f|--from
      The format to convert from. Default is: $from. Choices: $(printf '%s\n' ${to_from_choices[@]})
      "
      echo "    -t|--to
      The format to convert to. Default is: $to. Choices: $(printf '%s\n' ${to_from_choices[@]})
      "
      echo "    -v|--verbose
      Display the renames happening. Default is: $verbose.
      "
      echo "    --preview
      When true, it does not preform the renames.
      When true, it also changes -v to true.
      For debugging and 'previewing' the change before performing it.
      Default is: $preview.
      "
      echo "    -h|--help"
      exit 1
      ;;

  esac
  shift
done


# rn_selected --directory . --from camel --to snake
# rn_selected --directory . --from kebab --to snake
# rn_selected --directory . --from space --to snake
# rn_selected --directory . --from space (--to empty_string)

for f in $directory
do
  echo "$f"
done