function cmd_exec {
  # executes command prompt commands or file
  local command="$1";
  [[ -z "$command" ]] && { echo "Must specify command parameter!" >&2; return 1; }
  cmd.exe "/c $command";
}