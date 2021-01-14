#!/bin/bash

# Default values
valC="X"
valN="10"
valM="left"
method_choices=("left", "right")

while [[ $# > 0 ]]
do
  case "$1" in

    -c|--character)
            valC="$2"
            shift
            ;;

    -n|--number)
            valN="$2"
            shift
            ;;

    -m|--method)
            valM="$2"
            shift
            ;;

    -h|--help)
            echo "Usage:"
            echo "    -c|--character \"Character to pad string with. Default is: $valC\""
            echo "    -n|--number \"Number of characters the string should be. Default is: $valN\""
            echo "    -m|--method \"Which way to pad the string. Default is: $valM. Choices: $(printf '%s\n' ${method_choices[@]})\""
            echo "    -h|--help"
            exit 1
            ;;

    *)
            strs="$@"
            break
            ;;

  esac
  shift
done

# [[ -p /dev/stdin ]] && { mapfile -t; set -- "${MAPFILE[@]}"; }

# TODO: validate each input for the flags

iN="$(printf '%d' $valN 2>/dev/null)"

declare -a arr
for str in ${strs[@]}
do
  while ((${#str} < $iN)); do 
    [[ "$valM" == "right" ]] && { str+="$valC"; }
    [[ "$valM" == "left" ]] && { str="$valC$str"; }
  done
  arr=( "${arr[@]}" "$str" )
done

printf '%s\n' "${arr[@]}"
