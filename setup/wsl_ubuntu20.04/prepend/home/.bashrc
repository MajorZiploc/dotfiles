
# PREPENDED CONTENT BEGIN
[[ -z $(which fzf 2>/dev/null) ]] && { ENV_NOTES="$ENV_NOTES:Missing fzf (fuzzy finder)"; }
[[ -z $(python -V | egrep "\b3") ]] && { ENV_NOTES="$ENV_NOTES:Missing python v3 "; }
# PREPENDED CONTENT END

