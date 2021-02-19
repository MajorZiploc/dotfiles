#!/bin/bash

# Default values
directory='*'
by="s/ / /"
verbose=false
preview=false

[[ $# == 0 ]] && {
  echo "rn_selected called with no arguments!"
  echo "rn_selected must be called with at least 1 argument"
  echo "use 'rn_selected -h' to see possible arguments"
  exit 1
}

while [[ $# > 0 ]]
do
  case "$1" in

    -d|--directory)
      directory="$2"
      shift
      ;;

    -b|--by)
      by="$2"
      shift
      ;;

    -a|--all)
      directory='* .[^.]*'
      ;;

    -v|--verbose)
      verbose=true
      ;;

    -p|--preview)
      verbose=true
      preview=true
      ;;

    -h|--help)
      echo "Command rn_selected (rename_selected):"
      echo "Utility for renaming folders and files"
      echo "Usage:"

      echo "    -d|--directory
      The directory to rename folders and files in. Non-recursive. Default is: '$directory'
      For all nonhidden files/folders in current directory non-recursive, use -d '*'
      For all hidden files/folders in current directory non-recursive, use -d '.[^.]*'
      For all hidden and nonhidden files/folders in current directory non-recursive, use -d '* .[^.]*'
      "

      echo "    -b|--by
      Program executed by 'sed -E' on each file name to derive new file name. Default is: $by.
      You can do multiple s/// by doing: --by 's///;s///;s///;'
      "

      echo "    -a|--all
      Short hand to iterate over all hidden and non hidden files in the directory non recursively.
      The same as specifying -d '* .[^.]*'
      "

      echo "    -v|--verbose
      Display the renames happening.
      "

      echo "    -p|--preview
      When specified, it does not preform the renames.
      When specified, it also toggles -v on.
      For debugging and 'previewing' the change before performing it.
      "

      echo "    -h|--help"
      exit 1
      ;;
  
    *)
      echo "command called with non valid flags!"
      echo "use 'rn_selected -h' to see options"
      exit 1
      ;;

  esac
  shift
done

[[ $verbose == true ]] && {
  echo "directory: $directory"
  echo "by: $by"
  echo "verbose: $verbose"
  echo "preview: $preview"
}

for f in $directory
do
  new_name=$(echo $f | sed -E "$by")
  [[ $f == $new_name ]] && {
    [[ $verbose == true ]] && {
      echo "No name change for file/folder $f";
      }
    }
  [[ $f != $new_name ]] && {
    [[ $verbose == true ]] && {
      echo "mv \"$f\" \"$new_name\"";
      }
    [[ $preview == false ]] && {
      mv "$f" "$new_name";
      }
    }
done


function make_copies {
  # args
  # required file
  local og_file="$1"
  # required file
  # local new_file_names=$(cat "$2")
  # optional folder path
  local copy_location="$3"

  local file_path=$(readlink -f $og_file)
  # set copy_location based on if it is given or not
  [[ -z "$copy_location" ]] && {
    copy_location=${file_path%/*}
  } || {
    copy_location=$(readlink -f "$copy_location")
  }
  # ensures that copy_location exists
  mkdir -p "$copy_location"
  local base_og_file=$(basename $file_path)

  # while loop allows for files with spaces in name
  # if line is blank, it will still make a copy based on that line
  while IFS="" read -r p || [ -n "$p" ]
  do
    local new_file_name="$p"
    local new_file_path="$copy_location/$new_file_name-$base_og_file";
    cp "$file_path" "$new_file_path"
  done < "$2"
}

