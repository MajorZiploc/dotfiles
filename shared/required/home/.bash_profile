# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return;;
esac

# Check for missing dependencies
export ENV_NOTES=""
[[ -z $(which npm 2>/dev/null) ]] && { ENV_NOTES="$ENV_NOTES:Missing npm (node package manager)"; }
[[ -z $(which tmux 2>/dev/null) ]] && { ENV_NOTES="$ENV_NOTES:Missing tmux (terminal multiplexier)"; }
[[ -z $(which pwsh 2>/dev/null) ]] && { ENV_NOTES="$ENV_NOTES:Missing pwsh (cross platform powershell)"; }
[[ -z $(which gnomon 2>/dev/null) ]] && { ENV_NOTES="$ENV_NOTES:Missing gnomon (npm package)"; }
[[ -z $(which rg 2>/dev/null) ]] && { ENV_NOTES="$ENV_NOTES:Missing rg (ripgrep). Important for the ripgrep plugin in vim"; }
[[ -z $(dotnet --version 2>/dev/null | egrep "^5") ]] && { ENV_NOTES="$ENV_NOTES:Missing dotnet v5. (cross platform dotnet cli tooling)"; }
[[ -z $(type -a python | egrep "[[:alpha:]]3") ]] && { ENV_NOTES="$ENV_NOTES:Missing python3."; }

test -f ~/.bashrc && . ~/.bashrc

# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

# Set MANPATH so it includes users' private man if it exists
if [ -d "${HOME}/man" ]; then
  MANPATH="${HOME}/man:${MANPATH}"
fi

# Set INFOPATH so it includes users' private info if it exists
if [ -d "${HOME}/info" ]; then
  INFOPATH="${HOME}/info:${INFOPATH}"
fi

# final check on environment
[[ -z "$ENV_NOTES" ]] && { ENV_NOTES="No missing dependencies! Setup is complete!"; }

# Remove duplicate entries from PATH. Keeping first occurence
export PATH=$(echo -n $PATH | awk -v RS=: '!($0 in a) {a[$0]; printf("%s%s", length(a) > 1 ? ":" : "", $0)}')

