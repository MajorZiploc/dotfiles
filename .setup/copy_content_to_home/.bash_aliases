shopt -s expand_aliases
# tmux aliases
alias tmuxas="tmux attach-session"
alias tmuxks="tmux kill-session"
alias tmuxksvr="tmux kill-server"
alias tmuxls="tmux ls"

# copy / paste aliases
alias pbcopy="clip.exe"
alias pbpaste="powershell.exe -command 'Get-Clipboard' | head -n -1"

# View path directories alias
alias show_path='echo $PATH | tr ":" "\n"'

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
alias rtrim="sed -E 's/[ '$'\t'']+$//'"
alias ltrim="sed -E 's/\s*(.*)/\1/g'"
alias trim="sed -E 's/[ '$'\t'']+$//' | sed -E 's/\s*(.*)/\1/g'"
alias keep_last='tac | awk "!x[\$0]++" | tac'

# Viewing directory information aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias h='history'

