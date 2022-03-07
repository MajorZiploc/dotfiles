# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST

function set_prompt {
  PROMPT='%F{#5fafaf}%m %(?.%F{cyan}.%F{red}[$?])%c';
	local can_i_run_sudo=$(sudo -n uptime 2>&1 | grep "load" | wc -l);
	if [ ${can_i_run_sudo} -gt 0 ]; then
		PROMPT+='%{$fg_bold[red]%}!%{$reset_color%}';
	fi
  PROMPT+=' %F{magenta}${vcs_info_msg_0_}%F{cyan}> %F{reset}';
}

precmd_functions+=set_prompt

