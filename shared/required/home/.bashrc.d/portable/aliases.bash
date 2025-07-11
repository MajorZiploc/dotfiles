# tmux aliases
alias tmuxas="tmux attach-session";
alias tmuxks="tmux kill-session";
alias tmuxksvr="tmux kill-server";
alias tmuxls="tmux ls";
alias t="tmuxps";

# text manipulation aliaes
alias rev_chars='perl -F"" -anle "print reverse @F" | perl -ple "s/^\r//"';
alias rev_lines='perl -e "'"print reverse <>"'"';
alias toggle_case='tr "[a-zA-Z]" "[A-Za-z]"';
alias camel_to_snake="sed -E 's/([A-Z])/_\L\1/g;s/^_//;'";
alias camel_to_kebab="sed -E 's/([A-Z])/-\L\1/g;s/^\-//;'";
alias camel_to_space="sed -E 's/([A-Z])/ \1/g;s/^ //;'";
alias snake_to_camel="sed -E 's/_+([a-zA-Z])/\U\1/gi;s/^([A-Z])/\l\1/;'";
alias snake_to_kebab="sed -E 's/_+/-/g;s/^-+//g;'";
alias snake_to_space="sed -E 's/_+/ /g'";
alias kebab_to_camel="sed -E 's/\-+([a-zA-Z])/\U\1/gi;s/^([A-Z])/\l\1/;'";
alias kebab_to_snake="sed -E 's/-+/_/g;s/^_+//g;'";
alias kebab_to_space="sed -E 's/-+/ /g'";
alias space_to_camel="sed -E 's/ +([a-zA-Z])/\U\1/g;s/^([A-Z])/\L\1/;'";
alias space_to_snake="sed -E 's/ +([a-zA-Z])/_\L\1/g;s/^_//;s/^([A-Z])/\L\1/;'";
alias space_to_kebab="sed -E 's/ +([a-zA-Z])/-\L\1/g;s/^-//;s/^([A-Z])/\L\1/;'";
alias to_lower="sed -E 's/([A-Z])/\L\1/g'";
alias to_upper="sed -E 's/([a-z])/\U\1/g'";
alias rtrim="sed -E 's/[ '$'\t'']+$//'";
alias ltrim="sed -E 's/\s*(.*)/\1/g'";
alias trim="rtrim | ltrim";
alias keep_last='rev_lines | awk "!x[\$0]++" | rev_lines';
alias keep_first='cat | awk "!x[\$0]++" | cat';
alias add_semicolons='sed -E "s/(.+)/\1;/;s/;;$/;/;"';
alias to_title_case='sed -E "s/\b(.)/\u\1/g"';
alias to_less_blank_lines='perl -00 -pe '"'"'s/\n{2,}(?=[^\n])/"\n"/g'"'";
alias paragraph_count='perl -00 -ne '"'"'BEGIN{$paragraph_count=0}; $paragraph_count=$paragraph_count + 1; END{print $paragraph_count};'"'"''
alias tab_to_space_2='sed -E "s,\t,  ,g"';
alias tab_to_space_4='sed -E "s,\t,    ,g"';
alias indent_4_to_2='perl -pe '"'"'s{^((?: {4})*)}{" " x (2*length($1)/4)}e'"'"'';
alias indent_2_to_4='perl -pe '"'"'s{^((?: {2})*)}{" " x (4*length($1)/2)}e'"'"'';
alias bash_remove_colors="sed 's/\x1B\[[0-9;]*[A-Za-z]//g'";
alias js_remove_comments="sed -E '/^\s*(\/\/|\/\*|\*\/|\*)/d;'";
alias sql_remove_comments="sed -E '/^\s*(--)/d;'";
alias bash_remove_comments="sed -E '/^\s*(\#)/d;'";
alias remove_blank_lines="sed -E '/^\s*$/d;'";
alias clean_cheat_sheet="bash_remove_colors | js_remove_comments | sql_remove_comments | bash_remove_comments | remove_blank_lines";

alias url_encode='sed -E '"'"'s/%/%25/g; s/ /%20/g; s/!/%21/g; s/"/%22/g; s/#/%23/g; s/\$/%24/g; s/\(/%28/g; s/\)/%29/g; s/\*/%2A/g; s/\+/%2B/g; s/,/%2C/g; s/\//%2F/g; s/:/%3A/g; s/;/%3B/g; s/\?/%3F/g; s/@/%40/g; s/\[/%5B/g; s/\\/%5C/g; s/\]/%5D/g; s/\^/%5E/g; s/_/%5F/g; s/`/%60/g; s/\{/%7B/g; s/\|/%7C/g; s/\}/%7D/g; s/~/%7E/g'"'"';'
# Removed patterns:
# s/'"'"'/%27/g; # SHOULD READD THIS ONE
alias url_decode='sed -E '"'"'s/%25/%/g; s/%20/ /g; s/%21/!/g; s/%22/"/g; s/%23/#/g; s/%24/\$/g; s/%28/\(/g; s/%29/\)/g; s/%2A/\*/g; s/%2B/\+/g; s/%2C/,/g; s/%2F/\//g; s/%3A/:/g; s/%3B/;/g; s/%3F/\?/g; s/%40/@/g; s/%5B/\[/g; s/%5C/\\/g; s/%5D/\]/g; s/%5E/\^/g; s/%5F/_/g; s/%60/`/g; s/%7B/\{/g; s/%7C/\|/g; s/%7D/\}/g; s/%7E/~/g'"'"';'
# s/=/%3D/g; s/\&/%26/g;
# Removed patterns:
# s/%27/'"'"'/g; # SHOULD READD THIS ONE
# s/%3D/=/g; s/%26/\&/g;

# Converts a string to a fuzzy search pattern
alias to_fuzz='sed -E "s/(\\w)/\\1\[^\[:blank:\]\]{0,3}/g" | sed "s/\[^\[:blank:\]\]{0,3}$//g"';

# bash_surround_expression
alias bse='sed -E "s,(.+),\"\$(\1)\","';
# bash_surround_stream
alias bss='sed -E "s,(.+),<(\1),"';
# bash_surround_stream_echo
alias bsse='sed -E "s,(.+),<(echo \"\1\"),"';
# bash_surround_var_multiline
alias bsvm='perl -0777 -ple "BEGIN{print \"var_name=\`cat << EOF\n\";};END{print \"EOF\n\`;\";};"';
# bash_surround_var_singleline
alias bsvs='trim | sed -E "s,(.+),var_name=\`\1\`;,"';
# bash_line_join
alias btj='tr -d "\n" | tr -d "\r"';
# Line break on ; or | if it is not followed by |
# bash_line_split
alias bts="perl -ne 's/(;|\|)(?:(?!;|\|))/\$1\\n/g; print;'";

# Viewing directory information aliases
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)";
  alias ls='ls --color=auto';
  alias grep='grep --color=auto';
  alias fgrep='fgrep --color=auto';
  alias grep -E='grep -E --color=auto';
fi
alias ll='ls -alF';
alias la='ls -A';
alias ld='ls -d */';
alias l='ls -CF';
alias less_r='less -r';
# forces file stream to reload when it is updated
alias less_f='less +F';
alias whence='type -a';

alias _grepn_files="sed -E 's/(.\S*?):[0-9]+:(.*?)/\1/g'";
alias grepn_files_freq="_grepn_files | sort | uniq -c | sort -n";
alias grepn_files_uniq="_grepn_files | sort | uniq";
alias find_items_hidden="sed -e 's/\.\///g' | grep -E \"\/\.\"";
alias find_items_nonhidden="sed -e 's/\.\///g' |  grep -Ev \"\/\.\"";
alias show_root_folder="sed -E 's,^\./([^/]*?).*,\1,'";
alias find_in_files_trim_block_search='sed -E "/^\s*$/d"';
alias find_files_trim_block_search='find_in_files_trim_block_search | sed -E "s,([^:]+).*,\1,g"';

# reexecutes last command that beings with a pattern. ex: fc -s grep -E
alias reexe='fc -s';

alias gv='vim . -S Session.vim "+:horizontal topleft Git"';

alias ctags_make='rg --files | ctags -R --links=no -L -';
alias cscope_make='cscope -b `rg --files`';

alias git_merge_keep_theirs="git merge -X theirs";
alias git_log_break_down="git log --stat --oneline --decorate";
alias git_graph="git log --oneline --decorate --all --graph";

alias to_winpath='sed -E "s,^/(\w)/,\U\1:/,g" | sed s,/,\\\\,g';
alias to_unixpath='sed -E "s,^(\w):,/\L\1,g" | sed s,\\\\,/,g';

# paste from clipboard
alias clipp="pwsh -command 'Get-Clipboard' | head -n -1";

alias cdf='cd "$(dirname `FUZZY_FINDER_CDF_PLACEHOLDER`)"';

alias sl='snip_log';
alias sbw='snip_bash_while';
alias sbws='snip_bash_while_stream';
alias sbfl='snip_bash_for_loop';

alias format_prefix_commas='perl -nle '"'"'BEGIN {$had_comma=false;};if (m~,\s*$~) {s/,\s*$//; s/(\s*)(.*)$/$1, $2/ if $had_comma eq true; $had_comma=true;} else {$had_comma=false;}print $_;'"'"'';

alias nvarchar_from_dbl_quote='sed -E '"'"'s,",'"'"'"'"'"'"'"'"' + CHAR(34) + N'"'"'"'"'"'"'"'"',g'"'"''
alias varchar_from_dbl_quote='sed -E '"'"'s,",'"'"'"'"'"'"'"'"' + CHAR(34) + '"'"'"'"'"'"'"'"',g'"'"''
