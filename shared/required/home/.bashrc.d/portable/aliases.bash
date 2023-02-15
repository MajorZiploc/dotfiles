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
alias bln="to_newlines"

# bash_surround_expression
alias bse='sed -E "s,(.+),\"\$(\1)\","'
# bash_surround_stream
alias bss='sed -E "s,(.+),<(\1),"'
# bash_surround_stream_echo
alias bsse='sed -E "s,(.+),<(echo \"\1\"),"'
# bash_surround_var_multiline
alias bsvm='perl -0777 -ple "BEGIN{print \"var_name=\`cat << EOF\n\";};END{print \"EOF\n\`;\";};"'
# bash_surround_var_singleline
alias bsvs='trim | sed -E "s,(.+),var_name=\`\1\`;,"'
# bash_line_join
alias blj='tr -d "\n" | tr -d "\r"'
# Line break on ; or | if it is not followed by |
# bash_line_split
alias bls="perl -ne 's/(;|\|)(?:(?!;|\|))/\$1\\n/g; print;'"

# Viewing directory information aliases
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias grep -E='grep -E --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias ld='ls -d */'
alias l='ls -CF'
alias less_r='less -r'
# forces file stream to reload when it is updated
alias less_f='less +F'
alias whence='type -a'

alias _grepn_files="sed -E 's/(.\S*?):[0-9]+:(.*?)/\1/g'"
alias grepn_files_freq="_grepn_files | sort | uniq -c | sort -n"
alias grepn_files_uniq="_grepn_files | sort | uniq"
alias find_items_hidden="sed -e 's/\.\///g' | grep -E \"\/\.\""
alias find_items_nonhidden="sed -e 's/\.\///g' |  grep -Ev \"\/\.\""
alias show_root_folder="sed -E 's,^\./([^/]*?).*,\1,'"

# reexecutes last command that beings with a pattern. ex: fc -s grep -E
alias reexe='fc -s'

alias vimi='vim -u NONE'
alias vimc='vim -u ~/vimfiles/rc-settings/common.vim'
alias vimt='vim -u ~/vimfiles/rc-settings/terminal.vim'
alias vimnp='vim --noplugin'

alias show_fn_names='declare -F'
alias show_fn_impls='declare -f'

alias back='cd ~-'

# requires <npm i gnomon -g> for the current user
alias time_js='gnomon'

alias git_merge_keep_theirs="git merge -X theirs"
alias git_log_break_down="git log --stat --oneline --decorate"
alias git_graph="git log --oneline --decorate --all --graph"
alias git_log_diff="git log --stat -p --ignore-space-change";

alias to_winpath='sed -E "s,^/(\w)/,\U\1:/,g" | sed s,/,\\\\,g'
alias to_unixpath='sed -E "s,^(\w):,/\L\1,g" | sed s,\\\\,/,g'

# paste from clipboard
alias clipp="pwsh -command 'Get-Clipboard' | head -n -1"

alias cdf='cd "$(dirname `FUZZY_FINDER_CDF_PLACEHOLDER`)"'

