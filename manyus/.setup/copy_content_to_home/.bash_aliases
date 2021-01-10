shopt -s expand_aliases
alias show_path='echo $PATH | tr ":" "\n"'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias rev_chars='perl -F"" -anle "print reverse @F" | perl -ple "s/^\r//"'
alias rev_lines='tac'
