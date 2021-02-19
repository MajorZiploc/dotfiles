#!/bin/bash

# Default values
verbose=false
preview=false

[[ $# == 0 ]] && {
  echo "make_copies called with no arguments!"
  echo "make_copies must be called with at least 1 argument"
  echo "use 'make_copies -h' to see possible arguments"
  exit 1
}

while [[ $# > 0 ]]
do
  case "$1" in

    -f|--file)
      og_file="$2"
      shift
      ;;

    -n|--new_file_names)
      new_file_names="$2"
      shift
      ;;

    -l|--copy_location)
      new_file_names="$2"
      shift
      ;;

    -v|--verbose)
      verbose=true
      ;;

    -p|--preview)
      verbose=true
      preview=true
      ;;

    -h|--help)
      echo "Command make_copies:"
      echo "Utility for making copies of a file given a list of new file names"
      echo "Usage:"

      echo "    -f|--file
      Required
      The file to make copies of.
      Must be a file
      "

      echo "    -n|--new_file_names
      Required
      The file containing the new names of the for the file.
      Only include the name, not the path.
      File names can have spaces.
      Each line will be used as a file name
      Must be a file
      "

      echo "    -l|--copy_location
      Optional
      The file location to store the copies.
      Defaults to location of original file.
      Must be a file path
      "

      echo "    -v|--verbose
      Display the copies happening.
      "

      echo "    -p|--preview
      When specified, it does not preform the copies.
      When specified, it also toggles -v on.
      For debugging and 'previewing' the change before performing it.
      "

      echo "    -h|--help"
      exit 1
      ;;
  
    *)
      echo "command called with non valid flags!"
      echo "use 'make_copies -h' to see options"
      exit 1
      ;;

  esac
  shift
done

# set copy_location
[[ -z "$copy_location" ]] && {
  # set copy_location based on og file path
  copy_location=${file_path%/*}
} || {
  # set copy_location based on optional copy_location param
  copy_location=$(readlink -f "$copy_location")
}

[[ $verbose == true ]] && {
  echo "file: $og_file"
  echo "new_file_names: $new_file_names"
  echo "copy_location: $copy_location"
  echo "verbose: $verbose"
  echo "preview: $preview"
}


function make_copies {
  # args
  # required file
  local og_file="$1"
  # required file
  local new_file_names="$2"
  # optional folder path
  local copy_location="$3"

  # location of the original file
  local file_path=$(readlink -f $og_file)
  # ensures that copy_location exists
  mkdir -p "$copy_location"
  # get base file name of the og file
  local base_og_file=$(basename $file_path)

  # while loop allows for files with spaces in name
  # if line is blank, it will still make a copy based on that line
  while IFS="" read -r p || [ -n "$p" ]
  do
    local new_file_name="$p"
    local new_file_path="$copy_location/$new_file_name-$base_og_file";
    [[ $verbose == true ]] && {
      echo "cp \"$file_path\" \"$new_file_path\"";
      echo "cp \"$f\" \"$new_name\"";
      }
    # perform the copy only if preview is false
    [[ $preview == false ]] && {
      cp "$file_path" "$new_file_path"
      }
  done < "$new_file_names"
}

make_copies "$file" "$new_file_names" "$copy_location"

