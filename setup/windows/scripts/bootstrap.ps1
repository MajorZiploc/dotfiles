# run in user directory

# install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# the -y on all cinst should remove the need for this global confirmation
# choco feature enable -n allowGlobalConfirmation

# install git and refresh path
choco install -y git
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# clone this repo
# git init
# git remote add origin https://github.com/MajorZiploc/dotfiles
# git fetch
# git reset origin/master
# git branch --set-upstream-to=origin/master
# git checkout HEAD -- .

Set-ExecutionPolicy Unrestricted -Scope LocalMachine

# show execution policies
Get-ExecutionPolicy -List
