ls "$HOME/.config/powershell/scripts" | % { . $_.FullName }

# NOTE: is fc in unix. dc is file compare in windows tho. so using gv instead
Set-Alias dc Invoke-FC
