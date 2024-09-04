[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $options="00001"
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
    choco install -y cascadia-code-nerd-font
    # web browser -- NOTE: DOESNT SEEM TO WORK
    # choco install -y googlechrome
    # clipboard tool
    choco install -y ditto
    # version control and git bash
    choco install -y git
    # oldschool version control SVN
    # choco install -y tortoisesvn
    # upzipping tool
    choco install -y 7zip
    # scroll wheels works on window mouse is over
    choco install -y wizmouse
    # scroll wheels works on window mouse is over
    # choco install -y katmouse # doesnt work at work, it doesnt follow proper choco package protocol
    # code editor
    choco install -y vscode
    # screenshot tool
    choco install -y lightshot
    # create gifs from screen
    choco install -y screentogif
    # scripting language for workflow automations
    # choco install -y autohotkey
    # for calling urls from cli
    choco install -y curl
    # display keystrokes on screen, one key at a time
    # choco install -y keypose
    # display keystrokes on screen, shows multiple keys at a time
    choco install -y keycastow
    # searching tool
    choco install -y ripgrep
    # for searching pdfs, ebooks, zips, etc...
    # choco install -y ripgrep-all
    # for fuzzy file finder
    # choco install -y fzf
    # vim tags
    choco install -y universal-ctags
    # pyenv for windows
    Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"
}

if (($optionsAsInt -band $GamingAsInt) -eq $GamingAsInt) {
    Write-Host("Installing Gaming packages")
    # Gaming Packages
    # java runtime 8
    choco install -y jre8
}

if (($optionsAsInt -band $CreativeAsInt) -eq $CreativeAsInt) {
    Write-Host("Installing Creative packages")
    # Creative Packages
    choco install -y krita
    # SVG editor
    choco install -y inkscape
    # photo editing tool
    # choco install -y gimp
    # compact image viewer and converter
    # choco install -y irfanview
    # photo editing tool - easier than gimp
    # choco install -y paint.net
}

if (($optionsAsInt -band $TechAsInt) -eq $TechAsInt) {
    Write-Host("Installing Tech packages")
    # Tech Packages
    # for handle.exe: a way to find out what program is using a folder/file so you can kill it
    # https://learn.microsoft.com/en-us/sysinternals/downloads/handle
    choco install -y sysinternals
    choco install -y jq
    # node package manager
    choco install -y nvm
    # a windows bash with package manager pacman
    # can use to download linux packages and reference in git bash
    # or just use this bash instead of git bash
    choco install -y msys2
    # prolog language
    # choco install -y swi-prolog
    # javascript runtime
    choco install -y nodejs
    # javascript package manager
    # choco install -y yarn
    # python language
    choco install -y python3
    # local testing of sending emails
    choco install -y smtp4dev
    # windows linux subsystem -- NOTE: requires download of a linux distro aswell
    # choco install -y wsl
    # choco install -y wsl2
    wsl --install
    # docker containerization platform -- NOTE: DOESNT SEEM TO WORK
    # choco install -y docker-desktop
    # installs cross platform powershel 7
    choco install -y powershell-core
    # java development kit 12
    choco install -y openjdk.portable
    # vim gui
    # choco install -y vim-tux
    # api manual testing
    # choco install -y postman
    # neovim
    choco install -y neovim
}

if (($optionsAsInt -band $WorkAsInt) -eq $WorkAsInt) {
    Write-Host("Installing Work packages")
    # Work Packages
    # communcations app
    choco install -y slack
    # runtime and cli tools for creating .NET core applications
    choco install -y dotnet-sdk
    choco install -y dotnet-runtime
}

# example of installing something (atom) for all users
# choco install atom -y --force --params "'ALLUSERS=1"
# jre + jdk 12
# choco install -y openjdk12

# look into these
# choco install -y nircmd
# choco install -y vlc

# install dev tools
# choco install -y gitkraken
# choco install -y linqpad5

# generate shims
# & "$env:ChocolateyInstall\tools\shimgen.exe" -p "$env:ChocolateyInstall\tools\shimgen.exe" -o "$env:ChocolateyInstall\bin\shimgen.exe"
# shimgen -p "C:\Program Files\Git\git-bash.exe" -o "$env:ChocolateyInstall\bin\git-bash.exe"
