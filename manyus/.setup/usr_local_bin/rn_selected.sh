#!/bin/bash

# Default values
directory='*'
by="s/ /_/g"
verbose=false
preview=false

while [[ $# > 0 ]]
do
  case "$1" in

    -d|--directory)
      directory="$2"
      shift
      ;;

    -b|--by)
      by=$2
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

      echo "    -b|--by
      Program executed by 'sed -e' on each file to derive new file name. Default is: $by.
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

echo "directory: $directory"
echo "by: $by"
echo "verbose: $verbose"
echo "preview: $preview"

# rn_selected --directory . --from camel --to snake
# rn_selected --directory . --from kebab --to snake
# rn_selected --directory . --from space --to snake
# rn_selected --directory . --from space (--to empty_string)

for f in $directory
do
  new_name=$(echo $f | sed -e "$by")
  [[ $f == $new_name ]] && { echo "No name change for file/folder $f"; }
  [[ $f != $new_name ]] && { echo "mv \"$f\" \"$new_name\""; }
done