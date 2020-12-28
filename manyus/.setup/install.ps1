[CmdletBinding()]
param (
    [Parameter()]
    [ValidateSet("Full", "Minimal")]
    [string]
    $type="Full"
)

# install apps
cinst -y googlechrome
cinst -y ditto
cinst -y git
cinst -y winrar
cinst -y 7zip
cinst -y katmouse
cinst -y vscode
cinst -y lightshot
cinst -y screentogif

if ("Full" -eq $type) {
    cinst -y gimp
    cinst -y swi-prolog
    cinst -y nodejs
    cinst -y python3 --version=3.8.6
    cinst -y vscode
    cinst -y smtp4dev
    # cinst -y slack
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
#cinst -y yarn
#cinst -y postman

# generate shims
# & "$env:ChocolateyInstall\tools\shimgen.exe" -p "$env:ChocolateyInstall\tools\shimgen.exe" -o "$env:ChocolateyInstall\bin\shimgen.exe"
# shimgen -p "C:\Program Files\Git\git-bash.exe" -o "$env:ChocolateyInstall\bin\git-bash.exe"
