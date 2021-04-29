shopt -s expand_aliases

[[ ! -z $(which tmux 2>/dev/null) ]] && {
  # tmux aliases
  alias tmuxas="tmux attach-session"
  alias tmuxks="tmux kill-session"
  alias tmuxksvr="tmux kill-server"
  alias tmuxls="tmux ls"
}

# copy to clipboard
[[ ! -z $(which clip.exe 2>/dev/null) ]] && {
  alias clip="clip.exe"
} || {
  [[ ! -z $(which xclip 2>/dev/null) ]] && {
    alias clip="xclip"
  }
}
[[ ! -z $(which pwsh 2>/dev/null) ]] && {
  # paste from clipboard
  alias clipp="pwsh -command 'Get-Clipboard' | head -n -1"
}

# View path directories alias
alias show_path='echo $PATH | tr ":" "\n"'
alias show_env_notes='echo $ENV_NOTES | tr ":" "\n" | egrep -v "^\\s*$"'

# text manipulation aliaes
alias rev_chars='perl -F"" -anle "print reverse @F" | perl -ple "s/^\r//"'
alias rev_lines='tac'
alias toggle_case='tr "[a-zA-Z]" "[A-Za-z]"'
alias camel_to_snake="sed -E 's/([A-Z])/_\L\1/g' | sed 's/^_//'"
alias snake_to_camel="sed -E 's/_([a-zA-Z])/\U\1/gi' | sed -E 's/^([A-Z])/\l\1/'"
alias snake_to_space="sed 's/_/ /g'"
alias camel_to_space="sed -E 's/([A-Z])/ \1/g' | sed 's/^ //'"
alias space_to_snake="sed -E 's/ ([a-zA-Z])/_\L\1/g' | sed -E 's/^_//' | sed -E 's/^([A-Z])/\L\1/'"
alias space_to_camel="sed -E 's/ ([a-zA-Z])/\U\1/g' | sed -E 's/^([A-Z])/\L\1/'"
alias to_lower="sed -E 's/([A-Z])/\L\1/g'"
alias to_upper="sed -E 's/([a-z])/\U\1/g'"
alias rtrim="sed -E 's/[ '$'\t'']+$//'"
alias ltrim="sed -E 's/\s*(.*)/\1/g'"
alias trim="rtrim | ltrim"
alias keep_last='tac | awk "!x[\$0]++" | tac'
alias keep_first='cat | awk "!x[\$0]++" | cat'
alias fcjl='tr -d "\n"'
alias fcsl="sed -E 's/([;|])/\1\n/g'"
alias join_lines='fcjl'
alias split_lines="fcsl"
alias to_fuzz='sed -E "s/(\\w)/\\1\\\\S{0,3}?/g" | sed "s/\\\\S{0,3}?$//g"'

# Viewing directory information aliases
alias dir='ls --format=vertical'
alias vdir='ls --format=long'
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='ls --color=auto --format=vertical'
  alias vdir='ls --color=auto --format=long'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias ld='ls -d */'
alias l='ls -CF'
alias ls_human='ls --human-readable --size -1 -S --classify'
alias less_r='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort

# Default to human readable figures
alias df_h='df -h'
alias du_h='du -h'

alias grepn_files="sed -E 's/(.\S*?):[0-9]+:(.*?)/\1/g'"
alias grepn_files_freq="grepn_files | sort | uniq -c | sort -n"
alias grepn_files_uniq="grepn_files | sort | uniq"
alias find_items_hidden="sed -e 's/\.\///g' | egrep \"\/\.\""
alias find_items_nonhidden="sed -e 's/\.\///g' | egrep -v \"\/\.\""

# reexecutes last command that beings with a pattern. ex: fc -s egrep
alias reexe='fc -s'

alias vimi='/usr/bin/vim -u NONE'
alias vimc='/usr/bin/vim -u ~/_commonvimrc'
alias vimt='/usr/bin/vim -u ~/_vimrcterm'
alias vimnp='/usr/bin/vim --noplugin'

alias curl_follow_redirects='curl -Lks'
alias curl_follow_redirects_ignore_security_exceptions='curl -0Lks'

alias show_fn_names='declare -F'
alias show_fn_impls='declare -f'

alias back='cd ~-'

[[ ! -z $(which gnomon 2>/dev/null) ]] && {
  # requires <npm i gnomon -g> for the current user
  alias time_js='gnomon'
}

alias git_merge_keep_theirs="git merge -X theirs"
alias git_deploy='git push && git checkout master && git merge develop --commit --no-edit && git push && git checkout develop'

alias to_winpath='sed s,^/c,c:,g | sed s,/,\\\\,g'
alias to_unixpath='sed s,^c:,/c,g | sed s,\\\\,/,g'

alias refresh_settings="/c/projects/home-settings/setup/windows/scripts/copy.sh && source ~/.bash_profile && echo 'Refreshed settings!'"

