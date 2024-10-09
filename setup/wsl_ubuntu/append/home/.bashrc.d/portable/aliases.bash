alias gsed='sed'
# for opening a gui file explorer
alias explorer="explorer.exe"
# copy to clipboard
alias clip="clip.exe"
alias vim='nvim'
alias pwd_wsl='echo "//wsl.localhost/Ubuntu`pwd`" | to_winpath'

alias to_winpath_wsl='sed -E "s,^/home,//wsl.localhost/Ubuntu/home,;s,^/mnt,,;s,^/(\w)/,\U\1:/,g" | sed s,/,\\\\,g';
\\wsl.localhost\Ubuntu\home\majorziploc\projects\background_worker.fs\bin\Debug\net8.0
alias to_unixpath_wsl='sed -E "s,^(\w):,/mnt/\L\1,g" | sed s,\\\\,/,g | sed -E "s,^//wsl.localhost/Ubuntu/home,/home,g"';
