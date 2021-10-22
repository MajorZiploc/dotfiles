# tmux aliases
alias tmuxas="tmux attach-session"
alias tmuxks="tmux kill-session"
alias tmuxksvr="tmux kill-server"
alias tmuxls="tmux ls"

# View path directories alias
alias show_path='echo $PATH | tr ":" "\n"'

# text manipulation aliaes
alias rev_chars='perl -F"" -anle "print reverse @F" | perl -ple "s/^\r//"'
alias rev_lines='tac'
alias toggle_case='tr "[a-zA-Z]" "[A-Za-z]"'
alias camel_to_snake="sed -E 's/([A-Z])/_\L\1/g;s/^_//;'"
alias snake_to_camel="sed -E 's/_([a-zA-Z])/\U\1/gi;s/^([A-Z])/\l\1/;'"
alias snake_to_space="sed 's/_/ /g'"
alias camel_to_space="sed -E 's/([A-Z])/ \1/g;s/^ //;'"
alias space_to_snake="sed -E 's/ ([a-zA-Z])/_\L\1/g;s/^_//;s/^([A-Z])/\L\1/;'"
alias space_to_camel="sed -E 's/ ([a-zA-Z])/\U\1/g;s/^([A-Z])/\L\1/;'"
alias to_lower="sed -E 's/([A-Z])/\L\1/g'"
alias to_upper="sed -E 's/([a-z])/\U\1/g'"
alias rtrim="sed -E 's/[ '$'\t'']+$//'"
alias ltrim="sed -E 's/\s*(.*)/\1/g'"
alias trim="rtrim | ltrim"
alias keep_last='tac | awk "!x[\$0]++" | tac'
alias keep_first='cat | awk "!x[\$0]++" | cat'
alias add_semicolons='sed -E "s/(.+)/\1;/;s/;;$/;/;"'

# Converts a string to a fuzzy search pattern
alias to_fuzz='sed -E "s/(\\w)/\\1\[^\[:blank:\]\]{0,3}/g" | sed "s/\[^\[:blank:\]\]{0,3}$//g"'
alias to_newlines='tr " " "\n"'

alias bash_surround_expression='sed -E "s,(.+),\"\$(\1)\","'
alias bash_surround_stream='sed -E "s,(.+),<(\1),"'
alias bash_surround_stream_echo='sed -E "s,(.+),<(echo \"\1\"),"'
alias bash_surround_var_multiline='perl -0777 -ple "BEGIN{print \"var_name=\`cat << EOF\n\";};END{print \"EOF\n\`;\";};"'
alias bash_surround_var_singleline='trim | sed -E "s,(.+),var_name=\`\1\`;,"'
alias bash_line_join='tr -d "\n" | tr -d "\r"'
# Line break on ; or | if it is not followed by |
alias bash_line_split="perl -ne 's/(;|\|)(?:(?!;|\|))/\$1\\n/g; print;'"

alias bse='bash_surround_expression'
alias bss='bash_surround_stream'
alias bsse='bash_surround_stream_echo'
alias bsvm='bash_surround_var_multiline'
alias bsvs='bash_surround_var_singleline'
alias blj='bash_line_join'
alias bls='bash_line_split'
alias bln='to_newlines'

# Viewing directory information aliases
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias ld='ls -d */'
alias l='ls -CF'
alias less_r='less -r'
# forces file stream to reload when it is updated
alias less_f='less +F'
alias whence='type -a'

alias grepn_files="sed -E 's/(.\S*?):[0-9]+:(.*?)/\1/g'"
alias grepn_files_freq="grepn_files | sort | uniq -c | sort -n"
alias grepn_files_uniq="grepn_files | sort | uniq"
alias find_items_hidden="sed -e 's/\.\///g' | egrep \"\/\.\""
alias find_items_nonhidden="sed -e 's/\.\///g' | egrep -v \"\/\.\""
alias show_root_folder="sed -E 's,^\./([^/]*?)/.*,\1,'"

# reexecutes last command that beings with a pattern. ex: fc -s egrep
alias reexe='fc -s'

alias vimi='/usr/bin/vim -u NONE'
alias vimc='/usr/bin/vim -u ~/vimfiles/rc-settings/common.vim'
alias vimt='/usr/bin/vim -u ~/vimfiles/rc-settings/terminal.vim'
alias vimnp='/usr/bin/vim --noplugin'

alias show_fn_names='declare -F'
alias show_fn_impls='declare -f'

alias back='cd ~-'

# requires <npm i gnomon -g> for the current user
alias time_js='gnomon'

alias git_merge_keep_theirs="git merge -X theirs"
alias git_deploy='git checkout develop && git pull && git push && git checkout master && git pull && git merge develop --commit --no-edit && git push && git checkout develop'
alias git_log_break_down="git log --stat --oneline --all --decorate"
alias git_graph="git log --oneline --decorate --all --graph"
alias git_log_diff="git log --all --stat -p";

alias to_winpath='sed -E "s,^/(\w)/,\U\1:/,g" | sed s,/,\\\\,g'
alias to_unixpath='sed -E "s,^(\w):,/\L\1,g" | sed s,\\\\,/,g'

# paste from clipboard
alias clipp="pwsh -command 'Get-Clipboard' | head -n -1"

alias cdf='cd "$(dirname `CDF_FUZZY_FINDER_PLACEHOLDER`)"'

BASH_ALIASES_PLACEHOLDER

