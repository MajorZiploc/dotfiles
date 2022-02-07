#!/usr/bin/env bash

softwareupdate --all --install --force

brew update
brew install tmux
mkdir ~/.nvm
brew install nvm
brew install node
nvm install node
brew install fzf
brew install ripgrep
# for Ag in vim
brew install the_silver_searcher
brew install just
brew install copyq
brew install bash-completion
brew install nvim
brew install dos2unix
# ssh
brew install openssh
brew install telnet

# instal xcode
xcode-select --install

# python deps
brew install openssl readline sqlite3 xz zlib

# rust
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
brew install rust-analyzer

# php
brew install php

# ruby deps
sudo gem install solargraph

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
brew install --cask keycastr

# Finder: set hidden files to show by default
defaults write http://com.apple.Finder AppleShowAllFiles -bool true
# Finder: show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Finder: disables .DS_Store creation
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Finder: display the quit option
defaults write com.apple.finder QuitMenuItem -bool true
# Finder: dont display a warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Finder: no delay for title/folder icon display
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0
# Finder: set size of side menu text/icons to small. Choices: 1, 2, 3
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1
# VSCode: allows key repeat if key is held down
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
# Clock: dont let the date separators flash
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false

# Personal Preferences
# Dock: sets dock icon size to small
# defaults write com.apple.dock tilesize -int 31
# Dock: sets dock position to bottom of screen
# defaults write com.apple.dock orientation -string bottom
# Dock: auto hide when mouse leaves dock area
# defaults write com.apple.dock autohide -bool true
# Dock: animation time for dock to disappear
# defaults write com.apple.dock autohide-time-modifier -float 0.5
# Dock: only opens if the mouse is still for n seconds
# defaults write com.apple.dock autohide-delay -float 0.5
# Dock: dont show recents
# defaults write com.apple.dock show-recents -bool false
# Dock: minimize animation effect. Choices: genie, scale, suck
# defaults write com.apple.dock mineffect -string scale
# Screenshots: disable shadows
# defaults write com.apple.screencapture disable-shadow -bool true
# Screenshots: include date in screenshot name
# defaults write com.apple.screencapture include-date -bool true
# Screenshots: set default location for screenshots
# defaults write com.apple.screencapture location -string ~/Desktop
# Screenshots: display a thumbnail after taking a screenshot
# defaults write com.apple.screencapture show-thumbnail -bool true
# Screenshots: format to save screenshots. Choices: png, jpg
# defaults write com.apple.screencapture "type" -string png
# Finder: dont use icloud by default
# defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# TextEdit: default format to .txt instead of .rtf
# defaults write com.apple.TextEdit RichText -bool false
# TimeMachine: when connecting a new disk, system dont not prompt to use it as a backup volume
# defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool false
# HelpMenu: can go behind other windows
# defaults write com.apple.helpviewer DevMode -bool true
# Dock: disable spring loading
# defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool false
# Music: dont show notifications
# defaults write com.apple.Music userWantsPlaybackNotifications -bool false
# Misc: dont display warning about "Application Downloaded from Internet"
# defaults write com.apple.LaunchServices LSQuarantine -bool false

# Extra Preferences
# Mission Control: reorder Spaces based on most recent use
# defaults write com.apple.dock mru-spaces -bool true
# Clock: set time format
# defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE MMM d  j:mm a\""
# if the above clock setting goes wrong, revert the format with:
# defaults delete com.apple.menuextra.clock "DateFormat"
# Xcode: do not show the build duration in the toolbar
# defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool false

