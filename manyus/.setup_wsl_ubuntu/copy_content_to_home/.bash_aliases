shopt -s expand_aliases
alias tmuxas="tmux attach-session"
alias tmuxks="tmux kill-session"
alias tmuxksvr="tmux kill-server"
alias tmuxls="tmux ls"
alias pbcopy="clip.exe"
alias pbpaste="powershell.exe -command 'Get-Clipboard' | head -n -1"
alias show_path='echo $PATH | tr ":" "\n"'
alias rev_chars='perl -F"" -anle "print reverse @F" | perl -ple "s/^\r//"'
alias rev_lines='tac'
alias toggle_case='tr "[a-zA-Z]" "[A-Za-z]"'
alias camel_to_snake="sed -E 's/([A-Z])/_\L\1/g' | sed 's/^_//'"
alias snake_to_camel="sed -E 's/[ _-]([a-z])/\U\1/gi' | sed -E 's/^([A-Z])/\l\1/'"
alias snake_to_space="sed 's/_/ /g'"
alias camel_to_space="sed -E 's/([A-Z])/ \1/g' | sed 's/^ //'"
alias space_to_snake="sed -E 's/[ \t]+([a-zA-Z])/_\L\1/g' | sed -E 's/^_//' | sed -E 's/^([A-Z])/\L\1/'"
alias space_to_camel="sed -E 's/[ \t]+([a-zA-Z])/\U\1/g' | sed -E 's/^([A-Z])/\L\1/'"
