#!/usr/bin/env bash

softwareupdate --all --install --force

brew update
brew install tmux
mkdir ~/.nvm
brew install nvm
brew install node
brew install fzf
brew install ripgrep
brew install just
brew install copyq
brew install bash-completion

# instal xcode
xcode-select --install

# python deps
brew install openssl readline sqlite3 xz zlib

# install asdf and its deps
brew install gpg
brew install gawk
brew install asdf

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
brew install --cask wine-stable

