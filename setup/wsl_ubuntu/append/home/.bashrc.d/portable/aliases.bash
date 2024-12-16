alias gsed='sed'
# for opening a gui file explorer
alias explorer="explorer.exe"
# copy to clipboard
alias clip="clip.exe"
alias pwd_wsl='echo "//wsl.localhost/Ubuntu`pwd`" | to_winpath'

alias to_winpath_wsl='sed -E "s,^/home,//wsl.localhost/Ubuntu/home,;s,^/mnt,,;s,^/(\w)/,\U\1:/,g" | sed s,/,\\\\,g';
alias to_unixpath_wsl='sed -E "s,^(\w):,/mnt/\L\1,g" | sed s,\\\\,/,g | sed -E "s,^//wsl.localhost/Ubuntu/home,/home,g"';
