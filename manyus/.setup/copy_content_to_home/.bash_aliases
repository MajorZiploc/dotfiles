shopt -s expand_aliases
alias show_path='echo $PATH | tr ":" "\n"'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias urev='perl -F"" -anle "print reverse @F" | perl -ple "s/\r//g"'
