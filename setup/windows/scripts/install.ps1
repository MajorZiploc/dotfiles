[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $options="0001"
)
$base = 2
$optionsAsBinaryString = $options
$optionsAsInt = [convert]::ToInt32($optionsAsBinaryString, $base)

$Minimal = "00001"
$MinimalAsInt = [convert]::ToInt32($Minimal, $base)
$Creative = "00010" # -- Art/Photo
$CreativeAsInt = [convert]::ToInt32($Creative, $base)
$Work = "00100"
$WorkAsInt = [convert]::ToInt32($Work, $base)
$Gaming = "01000"
$GamingAsInt = [convert]::ToInt32($Gaming, $base)
$Tech = "10000"
$TechAsInt = [convert]::ToInt32($Tech, $base)

# install apps
if (($optionsAsInt -band $MinimalAsInt) -eq $MinimalAsInt) {
    Write-Host("Installing Minimal packages")
    # Minimal packages
    # web browser
    cinst -y googlechrome
    # clipboard tool
    cinst -y ditto
    # version control and git bash
    cinst -y git
    # upzipping tool
    cinst -y 7zip
    # scroll wheels works on window mouse is over
    cinst -y wizmouse
    # scroll wheels works on window mouse is over
    # cinst -y katmouse # doesnt work at work, it doesnt follow proper choco package protocol
    # code editor
    cinst -y vscode
    # screenshot tool
    cinst -y lightshot
    # create gifs from screen
    cinst -y screentogif
    # scripting language for workflow automations
    cinst -y autohotkey
    # for calling urls from cli
    cinst -y curl
    # display keystrokes on screen, one key at a time
    # cinst -y keypose
    # display keystrokes on screen, shows multiple keys at a time
    cinst -y keycastow
    # for vim grep plugin
    cinst -y ripgrep
    # for searching pdfs, ebooks, zips, etc...
    cinst -y ripgrep-all
    # for fuzzy file finder
    cinst -y fzf
}

if (($optionsAsInt -band $GamingAsInt) -eq $GamingAsInt) {
    Write-Host("Installing Gaming packages")
    # Gaming Packages
    # java runtime 8
    cinst -y jre8
}

if (($optionsAsInt -band $CreativeAsInt) -eq $CreativeAsInt) {
    Write-Host("Installing Creative packages")
    # Creative Packages
    # photo editing tool
    cinst -y gimp
    # compact image viewer and converter
    cinst -y irfanview
    # photo editing tool - easier than gimp
    cinst -y paint.net
}

if (($optionsAsInt -band $TechAsInt) -eq $TechAsInt) {
    Write-Host("Installing Tech packages")
    # Tech Packages
    # a windows bash with package manager pacman
    # can use to download linux packages and reference in git bash
    # or just use this bash instead of git bash
    # cinst -y msys2
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
    # installs cross platform powershel 7
    cinst -y powershell-core
    # java development kit 12
    cinst -y openjdk.portable
    # vim gui
    cinst -y vim-tux
}

if (($optionsAsInt -band $WorkAsInt) -eq $WorkAsInt) {
    Write-Host("Installing Work packages")
    # Work Packages
    # communcations app
    cinst -y slack
    # runtime and cli tools for creating .NET core applications
    cinst -y dotnetcore-sdk
}

# adds windows terminal manager, didnt seem to work
# cinst -y microsoft-windows-terminal
# example of installing something (atom) for all users
# choco install atom -y --force --params "'ALLUSERS=1"
# jre + jdk 12
# cinst -y openjdk12

# look into these
# cinst -y logitechgaming
# cinst -y vim-tux
# cinst -y autohotkey
# cinst -y nircmd
# cinst -y vlc

# install dev tools
# cinst -y gitkraken
# cinst -y linqpad5
# cinst -y fake
# cinst -y visualstudio2019-workload-manageddesktopbuildtools
# cinst -y postman

# generate shims
# & "$env:ChocolateyInstall\tools\shimgen.exe" -p "$env:ChocolateyInstall\tools\shimgen.exe" -o "$env:ChocolateyInstall\bin\shimgen.exe"
# shimgen -p "C:\Program Files\Git\git-bash.exe" -o "$env:ChocolateyInstall\bin\git-bash.exe"
