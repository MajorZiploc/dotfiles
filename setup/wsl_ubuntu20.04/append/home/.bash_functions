
# APPENDED CONTENT BEGIN
function show_env_notes() {
  # Look towards the end of this file for an override of this function
  export ENV_NOTES="";
  show_env_notes_shared;
  [[ -z $(which fzf 2>/dev/null) ]] && { ENV_NOTES="$ENV_NOTES:Missing fzf (fuzzy finder)"; }
  [[ -z $(python -V 2>/dev/null | egrep "\b3") ]] && { ENV_NOTES="$ENV_NOTES:Missing python v3 "; }
  # final check on environment
  [[ -z "$ENV_NOTES" ]] && { ENV_NOTES="No missing dependencies! Setup is complete!"; }
  echo $ENV_NOTES | tr ":" "\n" | egrep -v "^\\s*$"
}

function cmd_exec {
  # executes command prompt commands or file
  local command="$1";
  [[ -z "$command" ]] && { echo "Missing command parameter!"; return 1; }
  cmd.exe "/c $1";
}

# APPENDED CONTENT END

