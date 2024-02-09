# NOTE: to view all settings
# defaults read <thing>
#  example: show all NSGlobalDomain settings
#  defaults read NSGlobalDomain
#  example: show NSGlobalDomain KeyRepeat setting
#  defaults read NSGlobalDomain KeyRepeat
# TODO: should look at all these settings and update/add more sets to this file
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
# VSCode Insiders: allows key repeat if key is held down
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false;
# VSCodium: allows key repeat if key is held down
defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false;
defaults write com.vscodium ApplePressAndHoldEnabled -bool false
defaults write com.microsoft.VSCodeExploration ApplePressAndHoldEnabled -bool false
# To enable global key-repeat: this is helpful if you're using Vim in a PWA like code-server
defaults write -g ApplePressAndHoldEnabled -bool false;
# If necessary, reset global default
# defaults delete -g ApplePressAndHoldEnabled
# Clock: dont let the date separators flash
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false;
# Makes key held down actions the quickest possible, <cmd>-<space> Keyboard for all options
defaults write NSGlobalDomain KeyRepeat -int 2;
# Finder: show path
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true;

# Personal Preferences
# Dock: sets dock icon size to small
defaults write com.apple.dock tilesize -int 31;
# Dock: sets dock position to bottom of screen
defaults write com.apple.dock orientation -string bottom;
# Dock: auto hide when mouse leaves dock area
defaults write com.apple.dock autohide -bool true;
# Dock: animation time for dock to disappear
defaults write com.apple.dock autohide-time-modifier -float 0.5;
# Dock: only opens if the mouse is still for n seconds
defaults write com.apple.dock autohide-delay -float 0.5;
# Dock: dont show recents
defaults write com.apple.dock show-recents -bool false;
# Dock: minimize animation effect. Choices: genie, scale, suck
defaults write com.apple.dock mineffect -string scale;
# Screenshots: disable shadows
defaults write com.apple.screencapture disable-shadow -bool true;
# Screenshots: include date in screenshot name
defaults write com.apple.screencapture include-date -bool true;
# Screenshots: set default location for screenshots
defaults write com.apple.screencapture location -string ~/Desktop;
# Screenshots: display a thumbnail after taking a screenshot
defaults write com.apple.screencapture show-thumbnail -bool true;
# Screenshots: format to save screenshots. Choices: png, jpg
defaults write com.apple.screencapture "type" -string png;
# Finder: dont use icloud by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false;
# TextEdit: default format to .txt instead of .rtf
defaults write com.apple.TextEdit RichText -bool false;
# TimeMachine: when connecting a new disk, system dont not prompt to use it as a backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool false;
# HelpMenu: can go behind other windows
defaults write com.apple.helpviewer DevMode -bool true;
# Dock: disable spring loading
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool false;
# Music: dont show notifications
# defaults write com.apple.Music userWantsPlaybackNotifications -bool false;
# Misc: dont display warning about "Application Downloaded from Internet"
# defaults write com.apple.LaunchServices LSQuarantine -bool false;

# Extra Preferences
# Mission Control: reorder Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool true;
# Clock: set time format
# defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE MMM d  j:mm a\"";
# if the above clock setting goes wrong, revert the format with:
# defaults delete com.apple.menuextra.clock "DateFormat";
# Xcode: do not show the build duration in the toolbar
# defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool false;

