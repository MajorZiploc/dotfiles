# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%F{red}@%F{green}%m:%F{cyan}%c %F{magenta}${vcs_info_msg_0_}%F{cyan}> %F{reset}'
