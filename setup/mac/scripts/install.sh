#!/usr/bin/env bash

brew update
brew install tmux
mkdir ~/.nvm
brew install nvm
brew install node
brew install fzf
brew install ripgrep
brew install just
brew install bash-completion

# dotnet core
brew install mono-libgdiplus
brew install --cask dotnet-sdk
brew install --cask powershell

# Dont forget to prepend this bash to the /etc/shell
# /opt/homebrew/bin/bash
brew install bash
brew install --cask google-chrome
brew install --cask iterm2
brew install --cask discord
brew install --cask visual-studio-code
brew install --cask slack
brew install --cask docker

