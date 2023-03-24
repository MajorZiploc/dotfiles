#!/usr/bin/env bash

this_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

softwareupdate --all --install --force;

# instal xcode
xcode-select --install;

brew update;
brew tap homebrew/cask-versions;
brew tap homebrew/cask-fonts

# general gnu utils
brew install coreutils;
brew install binutils;
brew install diffutils;
brew install ed;
brew install findutils;
brew install gawk;
brew install gnu-indent;
brew install gnu-sed;
brew install gnu-tar;
brew install gnu-which;
brew install gnutls;
brew install grep;
brew install gzip;
brew install screen;
brew install watch;
brew install wdiff;
brew install wget;

# general gnu utils extras
brew install gpatch;
brew install less;
brew install m4;
brew install make;
# brew install gdb;  # gdb requires further actions to make it work. See `brew info gdb`.
# brew install nano;
# brew install emacs;

# newer versions of macOS existing tooling
brew install zsh;
brew install file-formula;
brew install git;
brew install openssh;
brew install perl;
brew install rsync;
# brew install svn;
brew install unzip;

brew install tmux;
# node version manager
mkdir ~/.nvm;
brew install nvm;
nvm install node;
# python version manager like nvm
brew install pyenv;
pyenv install 3.8.10;
pyenv global 3.8.10;
# fuzzy finder
brew install fzf;
# a grepper that can look inside binary files like pdf's
brew install ripgrep;
# for Ag in vim
brew install the_silver_searcher;
# just command line runner
brew install just;
# a better system copy tray that acts as a stack
brew install copyq;
brew install bash-completion;
# neovim
brew install neovim;
# convert files for OS'es, comes with others like unix2dos
brew install dos2unix;
# json query for cli
brew install jq;
# yaml query for cli
brew install yq;
# ssh
brew install openssh;
brew install telnet;
# prolog
brew install swi-prolog;
# for vim coc prolog language server support
swipl -q -l "$this_path/../../../shared/scripts/prolog/install_language_server.pl";
# help address issues in shell scripts
brew install shellcheck;

# python deps
brew install openssl readline sqlite3 xz zlib;

# rust
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh;
brew install rust-analyzer;

# java
# brew install java11;
brew install --cask corretto17
brew install openjdk@17
brew install --ignore-dependencies gradle;
brew install --ignore-dependencies maven;

brew pin openjdk;
brew pin gradle;
brew pin maven;

# golang
brew install golang;
# bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer);
# . ~/.gvm/scripts/gvm;
# gvm install go1.18;
# gvm use go1.18;

# php
brew install php;
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";
php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;";
php composer-setup.php;
php -r "unlink('composer-setup.php');";
sudo mv composer.phar /usr/local/bin/composer;
rm composer.phar;

# ruby deps
brew install gnupg;
# is this needed still? it was needed when using rvm, does rbenv need it?
# gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
brew install rbenv ruby-build;
sudo gem install solargraph;

# install asdf and its deps
brew install gpg;
brew install asdf;

# dotnet core
brew install mono-libgdiplus;
brew install --cask dotnet-sdk;
brew install --cask powershell;
dotnet tool install -g fsautocomplete;

# Dont forget to prepend this bash to the /etc/shell
# /opt/homebrew/bin/bash
brew install bash;
brew install --cask google-chrome;
brew install --cask iterm2;
brew install --cask discord;
brew install --cask gimp;
brew install --cask krita;
brew install --cask visual-studio-code;
brew install --cask slack;
brew install --cask docker;
# k8s: docker compose to k8s resources helper
brew install kompose
# k8s: minikube for runnning clusters locally
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-arm64
sudo install minikube-darwin-arm64 /usr/local/bin/minikube

brew install --cask wine-stable;
brew install --cask keycastr;

brew install --cask font-hack-nerd-font

# Finder: set hidden files to show by default
defaults write http://com.apple.Finder AppleShowAllFiles -bool true;
# Finder: show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true;
# Finder: disables .DS_Store creation
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true;
# Finder: display the quit option
defaults write com.apple.finder QuitMenuItem -bool true;
# Finder: dont display a warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false;
# Finder: no delay for title/folder icon display
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0;
# Finder: set size of side menu text/icons to small. Choices: 1, 2, 3
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1;
# VSCode: allows key repeat if key is held down
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false;
# Clock: dont let the date separators flash
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false;
# Makes key held down actions the quickest possible, <cmd>-<space> Keyboard for all options
defaults write NSGlobalDomain KeyRepeat -int 0;
# Finder: show path
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true;

# Personal Preferences
# Dock: sets dock icon size to small
# defaults write com.apple.dock tilesize -int 31;
# Dock: sets dock position to bottom of screen
# defaults write com.apple.dock orientation -string bottom;
# Dock: auto hide when mouse leaves dock area
# defaults write com.apple.dock autohide -bool true;
# Dock: animation time for dock to disappear
# defaults write com.apple.dock autohide-time-modifier -float 0.5;
# Dock: only opens if the mouse is still for n seconds
# defaults write com.apple.dock autohide-delay -float 0.5;
# Dock: dont show recents
# defaults write com.apple.dock show-recents -bool false;
# Dock: minimize animation effect. Choices: genie, scale, suck
# defaults write com.apple.dock mineffect -string scale;
# Screenshots: disable shadows
# defaults write com.apple.screencapture disable-shadow -bool true;
# Screenshots: include date in screenshot name
# defaults write com.apple.screencapture include-date -bool true;
# Screenshots: set default location for screenshots
# defaults write com.apple.screencapture location -string ~/Desktop;
# Screenshots: display a thumbnail after taking a screenshot
# defaults write com.apple.screencapture show-thumbnail -bool true;
# Screenshots: format to save screenshots. Choices: png, jpg
# defaults write com.apple.screencapture "type" -string png;
# Finder: dont use icloud by default
# defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false;
# TextEdit: default format to .txt instead of .rtf
# defaults write com.apple.TextEdit RichText -bool false;
# TimeMachine: when connecting a new disk, system dont not prompt to use it as a backup volume
# defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool false;
# HelpMenu: can go behind other windows
# defaults write com.apple.helpviewer DevMode -bool true;
# Dock: disable spring loading
# defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool false;
# Music: dont show notifications
# defaults write com.apple.Music userWantsPlaybackNotifications -bool false;
# Misc: dont display warning about "Application Downloaded from Internet"
# defaults write com.apple.LaunchServices LSQuarantine -bool false;

# Extra Preferences
# Mission Control: reorder Spaces based on most recent use
# defaults write com.apple.dock mru-spaces -bool true;
# Clock: set time format
# defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE MMM d  j:mm a\"";
# if the above clock setting goes wrong, revert the format with:
# defaults delete com.apple.menuextra.clock "DateFormat";
# Xcode: do not show the build duration in the toolbar
# defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool false;

