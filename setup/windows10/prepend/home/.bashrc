
# PREPENDED CONTENT BEGIN
[[ -z $(which fzy 2>/dev/null) ]] && { ENV_NOTES="$ENV_NOTES:Missing fzy (stdin fuzzy finder)"; }
[[ -z $(python -V 2>/dev/null | egrep "\b3") ]] && { ENV_NOTES="$ENV_NOTES:Missing python v3 "; }
# PREPENDED CONTENT END

