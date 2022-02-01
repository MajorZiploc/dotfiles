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
# for creating python virtual environments
sudo apt-get -y install python3-venv
# ripgrep for vundle use or use on its own
sudo add-apt-repository ppa:x4121/ripgrep
sudo apt-get -y update
sudo apt-get -y install ripgrep
# fuzzy finder
# make sure this isnt around (its to old for the vim plugin)
sudo apt-get -y remove fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
sed -E -i'' 's,curl -[^[:blank:]]+,curl -0Lk,g' ~/.fzf/install
~/.fzf/install
# for Ag in vim
sudo apt-get -y install silversearcher-ag
# zsh
sudo apt-get install -y zsh
# vim 8.2
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
# neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get install -y neovim

# nodejs nvm deps
sudo apt install -y build-essential checkinstall libssl-dev
curl -Lk https://raw.githubusercontent.com/creationix/nvm/v0.35.1/install.sh | bash

# Adds microsoft packages to trusted hosts
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo rm packages-microsoft-prod.deb

# dotnet cli and deps
sudo apt-get -y install apt-transport-https
sudo apt-get -y update
sudo apt-get -y install dotnet-sdk-6.0

# snapd
sudo apt install snapd

# update pip
python -m pip install --upgrade pip

# vim with clipboard support
sudo apt-get -y remove vim-common vim-runtime vim
sudo apt-get -y install --upgrade vim-common vim-runtime vim
sudo apt-get -y install vim-gtk
# clipboard tool
sudo apt-get -y install xclip
# clipboard manager, open its configs and make ctrl-` the Shortcuts -> Global -> Show the tray menu key
sudo apt-get -y install copyq

# docker
# from: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04
sudo apt-get -y remove docker docker-engine docker.io containerd runc
sudo apt-get -y update
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt -y update
apt-cache policy docker-ce
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

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

# another way to install docker
# sudo apt-get -y install \
    # apt-transport-https \
    # ca-certificates \
    # curl \
    # gnupg \
    # lsb-release
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# echo \
    # "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu
# \
    # $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt-get -y update
# sudo apt-get -y install docker-ce docker-ce-cli containerd.io

# docker terminal auto completion
sudo curl \
      -L https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/bash/docker-compose \
          -o /etc/bash_completion.d/docker-compose

sudo apt -y upgrade

# ruby
sudo apt install -y ruby-full
sudo gem install solargraph
