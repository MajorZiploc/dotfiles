#!/usr/bin/env bash

sudo apt -y update
# session manager
sudo apt-get -y install tmux
# for cr formatting between dos and unix. gives dos2unix and unix2dos
sudo apt-get -y install dos2unix
# view directories in tree format
sudo apt-get -y install tree
# creates a 'python' and makes it point to python3 that is installed
sudo apt-get -y install python-is-python3
# ripgrep for vundle use or use on its own
sudo apt-get -y install ripgrep
# fuzzy finder
# make sure this isnt around (its to old for the vim plugin)
sudo apt-get -y remove fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
sed -E -i'' 's,curl -[^[:blank:]]+,curl -0Lk,g' ~/.fzf/install
~/.fzf/install
# google chrome
sudo apt-get install -y curl unzip xvfb libxi6 libgconf-2-4
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
sudo rm ./google-chrome-stable_current_amd64.deb
# google driver
wget https://chromedriver.storage.googleapis.com/86.0.4240.22/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
sudo mv chromedriver /usr/bin/chromedriver
sudo chown root:root /usr/bin/chromedriver
sudo chmod +x /usr/bin/chromedriver
sudo rm -rf chromedriver_linux64.zip
# zsh
sudo apt-get install -y zsh
# vim 8.2
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
# neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get install -y neovim

# install nvm for nodejs
sudo apt install -y build-essential checkinstall libssl-dev
curl -o- HTTPS://raw.githubusercontent.com/creationix/nvm/v0.35.1/install.sh | bash

# Adds microsoft packages to trusted hosts
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo rm packages-microsoft-prod.deb

# dotnet cli and deps
sudo apt-get install -y apt-transport-https
sudo apt-get update
sudo apt-get install -y dotnet-sdk-3.1
sudo apt-get install -y dotnet-sdk-5.0

# powershell
# Install pre-requisite packages.
sudo apt-get install -y wget apt-transport-https software-properties-common
# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb
# Update the list of products
sudo apt-get update
# Enable the "universe" repositories
sudo add-apt-repository universe
# Install PowerShell
sudo apt-get install -y powershell
# Cleanup
sudo rm packages-microsoft-prod.deb

# update pip
python -m pip install --upgrade pip

# installs extra packages for google chrome, needed for automation tools like puppeteer js
sudo apt-get update \
  && sudo apt-get install -y wget gnupg \
  && sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && sudo apt-get update \
  && sudo apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
  --no-install-recommends #\
      # not sure why this is recommended to do for extra packages of google chrome
    #&& sudo rm -rf /var/lib/apt/lists/*

sudo apt -y upgrade

