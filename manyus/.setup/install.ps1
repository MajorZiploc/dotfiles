[CmdletBinding()]
param (
    [Parameter()]
    [ValidateSet("Full", "Minimal")]
    [string]
    $type="Full"
)

# install apps

# web browser
cinst -y googlechrome
# clipboard tool
cinst -y ditto
# version control and git bash
cinst -y git
# upzipping tool
cinst -y winrar
# upzipping tool
cinst -y 7zip
# scroll wheels works on window mouse is over
cinst -y katmouse
# code editor
cinst -y vscode
# screenshot tool
cinst -y lightshot
# create gifs from screen
cinst -y screentogif

if ("Full" -eq $type) {
    # photo editing tool
    cinst -y gimp
    # prolog language
    cinst -y swi-prolog
    # javascript runtime
    cinst -y nodejs
    # javascript package manager
    cinst -y yarn
    # python language
    cinst -y python3 --version=3.8.6
    # local testing of sending emails
    cinst -y smtp4dev
    # windows linux subsystem -- NOTE: requires download of a linux distro aswell
    cinst -y wsl
    # jre + jdk 11
    cinst -y openjdk12
    # communcations app
    cinst -y slack
}

# look into these
# cinst -y logitechgaming
# cinst -y vim-tux
# cinst -y autohotkey
# cinst -y nircmd
# cinst -y vlc
# cinst -y irfanview

# install dev tools
# cinst -y gitkraken
# cinst -y linqpad5
# cinst -y dotnetcore-sdk
# cinst -y fake
#cinst -y visualstudio2019-workload-manageddesktopbuildtools
#cinst -y postman

# generate shims
# & "$env:ChocolateyInstall\tools\shimgen.exe" -p "$env:ChocolateyInstall\tools\shimgen.exe" -o "$env:ChocolateyInstall\bin\shimgen.exe"
# shimgen -p "C:\Program Files\Git\git-bash.exe" -o "$env:ChocolateyInstall\bin\git-bash.exe"
