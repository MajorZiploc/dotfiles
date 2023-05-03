function cmd_wrap {
  local cmd="$1";
  # from std out redirect with pipe
  input=$(cat)
  eval "$cmd $input";
}

