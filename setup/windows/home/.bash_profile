# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return;;
esac

# Check for missing dependencies
export ENV_NOTES=""
[[ -d ~/AppData/Roaming/npm ]] || { ENV_NOTES="$ENV_NOTES\nMissing ~/AppData/Roaming/npm"; }
[[ -z $(which tmux 2>/dev/null) ]] && { ENV_NOTES="$ENV_NOTES\nMissing tmux (terminal multiplexier)"; }
[[ -z $(which pwsh 2>/dev/null) ]] && { ENV_NOTES="$ENV_NOTES\nMissing pwsh (cross platform powershell)"; }
[[ -z $(which gnomon 2>/dev/null) ]] && { ENV_NOTES="$ENV_NOTES\nMissing gnomon (npm package)"; }
[[ -z $(which rg 2>/dev/null) ]] && { ENV_NOTES="$ENV_NOTES\nMissing rg (ripgrep). Important for the ripgrep plugin in vim"; }
[[ -z "$ENV_NOTES" ]] && { ENV_NOTES="No missing dependencies! Setup is complete!"; } || { ENV_NOTES=$(printf "$ENV_NOTES"); }

test -f ~/.profile && . ~/.profile
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

# Remove duplicate entries from PATH. Keeping first occurence
export PATH=$(echo -n $PATH | awk -v RS=: '!($0 in a) {a[$0]; printf("%s%s", length(a) > 1 ? ":" : "", $0)}')

