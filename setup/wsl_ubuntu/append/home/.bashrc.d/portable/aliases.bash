alias gsed='sed'
# for opening a gui file explorer
alias explorer="explorer.exe"
# copy to clipboard
alias clip="clip.exe"
alias vim='nvim'
alias pwd_wsl='echo "//wsl.localhost/Ubuntu`pwd`" | to_winpath'

alias to_winpath_wsl='sed -E "s,/mnt,,g;s,^/(\w)/,\U\1:/,g" | sed s,/,\\\\,g';
alias to_unixpath_wsl='sed -E "s,^(\w):,/mnt/\L\1,g" | sed s,\\\\,/,g';
