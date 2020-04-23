# install apps
cinst googlechrome
cinst vim-tux
cinst clipx
cinst katmouse
cinst autohotkey
cinst nircmd
cinst vlc
cinst irfanview
cinst 7zip
cinst slack
#cinst gimp
#cinst screentogif
#cinst logitechgaming

# install dev tools
cinst gitkraken
cinst vscode
cinst linqpad5
cinst dotnetcore-sdk
cinst fake
#cinst visualstudio2019-workload-manageddesktopbuildtools
#cinst yarn
#cinst smtp4dev
#cinst postman

# install plugins for apps
git clone https://github.com/VundleVim/Vundle.vim.git ../.vim/bundle/Vundle.vim
vim +PluginInstall +qall
mkdir ..\.vim\swap

code --install-extension Shan.code-settings-sync

# generate shims
& "$env:ChocolateyInstall\tools\shimgen.exe" -p "$env:ChocolateyInstall\tools\shimgen.exe" -o "$env:ChocolateyInstall\bin\shimgen.exe"
shimgen -p "C:\Program Files\Git\git-bash.exe" -o "$env:ChocolateyInstall\bin\git-bash.exe"

# system settings
& "$env:userprofile\.ahk\hotkeys.ahk"
nircmd shortcut "$env:userprofile\.ahk\hotkeys.ahk" '~$folder.startup$' "Hotkeys"

REGEDIT /S CapsToControl-ScrollToCaps.reg
