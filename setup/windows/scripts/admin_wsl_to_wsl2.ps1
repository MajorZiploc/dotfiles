# Steps from:
# https://www.omgubuntu.co.uk/how-to-install-wsl2-on-windows-10

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# may require this if you cant set the version to wsl2
# https://docs.microsoft.com/en-us/windows/wsl/install-win10#step-4---download-the-linux-kernel-update-package
wsl --set-default-version 2

# TODO:
# should list linux os'es
# currently it is not listing any even though I have ubuntu installed
# stuck here on laptop. have yet to do this process on other machines
wsl -l

