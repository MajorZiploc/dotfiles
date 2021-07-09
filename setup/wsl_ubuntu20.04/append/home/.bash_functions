
# APPENDED CONTENT BEGIN

function cmd_exec {
  # executes command prompt commands or file
  local command="$1";
  [[ -z "$command" ]] && { echo "Missing command parameter!" >&2; return 1; }
  cmd.exe "/c $1";
}

# APPENDED CONTENT END

