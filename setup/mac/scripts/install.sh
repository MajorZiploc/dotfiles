#!/usr/bin/env bash

this_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

flags="$1";
[[ -z "$flags" ]] && { flags='0'; }
flags_as_int="$((2#$flags))";
full_install="$((2#1))";

softwareupdate --all --install --force;

# instal xcode
xcode-select --install;

# pre brew

# node
mkdir ~/.nvm;

[[ $(($full_install & $flags_as_int)) == $full_install ]] && {
  # rust
  curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh;
}

if [[ $(($full_install & $flags_as_int)) == $full_install ]]; then
  # brew update;
  cp "$this_path/Brewfile" "$HOME/";
else
  # brew update;
  echo "$(cat "$this_path/Brewfile" | sed -E "s,(.*\# full_install)$,# \\1,g")" | tee "$HOME/Brewfile";
fi
( cd "$HOME/" || return 1; brew bundle; )

# post brew
export NVM_DIR=~/.nvm;
source "$(brew --prefix nvm)/nvm.sh";
nvm install node;

pyenv install 3.11.2;
pyenv global 3.11.2;

[[ $(($full_install & $flags_as_int)) == $full_install ]] && {
  # for vim coc prolog language server support
  swipl -q -l "$this_path/../../../shared/scripts/prolog/install_language_server.pl";

  # golang
  # bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer);
  # . ~/.gvm/scripts/gvm;
  # gvm install go1.18;
  # gvm use go1.18;

  # php
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";
  php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
  php composer-setup.php;
  php -r "unlink('composer-setup.php');";
  sudo mv composer.phar /usr/local/bin/composer;
  rm composer.phar;

  # ruby deps
  sudo gem install solargraph;

  # k8s: minikube for runnning clusters locally
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-arm64
  sudo install minikube-darwin-arm64 /usr/local/bin/minikube
  rm minikube-darwin-arm64;
}

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

