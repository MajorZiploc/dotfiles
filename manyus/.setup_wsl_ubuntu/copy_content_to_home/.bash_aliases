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
