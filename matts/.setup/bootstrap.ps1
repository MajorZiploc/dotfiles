# run in user directory

# install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation

# install git and refresh path
cinst git
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# clone this repo
git init
git remote add origin https://github.com/mattstermiller/home-settings.git
git fetch
git reset origin/master
git branch --set-upstream-to=origin/master
git checkout HEAD -- .
