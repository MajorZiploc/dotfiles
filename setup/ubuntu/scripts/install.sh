#!/usr/bin/env bash

this_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

sudo apt-get -y update;
# ensure basic system dependencies: from pyenv install steps: https://www.liquidweb.com/kb/how-to-install-pyenv-on-ubuntu-18-04/
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
  libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl \
  git;
# session manager
sudo apt-get -y install tmux;
# for cr formatting between dos and unix. gives dos2unix and unix2dos
sudo apt-get -y install dos2unix;
# json query for cli
sudo apt-get -y install jq;
# yaml query for cli
sudo add-apt-repository ppa:rmescandon/yq -y;
sudo apt-get -y update;
sudo apt-get install yq -y;
# view directories in tree format
sudo apt-get -y install tree;
# creates a 'python' and makes it point to python3 that is installed
sudo apt-get -y install python-is-python3;
# for creating python virtual environments
sudo apt-get -y install python3-venv;
# pyenv: python version manager
git clone https://github.com/pyenv/pyenv.git ~/.pyenv;
# ripgrep for vundle use or use on its own
sudo add-apt-repository ppa:x4121/ripgrep -y;
sudo apt-get -y update;
sudo apt-get -y install ripgrep;
# fuzzy finder
# make sure this isnt around (its to old for the vim plugin)
sudo apt-get -y remove fzf;
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf;
sed -E -i'' 's,curl -[^[:blank:]]+,curl -0Lk,g' ~/.fzf/install;
~/.fzf/install;
# for Ag in vim
sudo apt-get -y install silversearcher-ag;
# zsh
sudo apt-get install -y zsh;
# vim 8.2
sudo add-apt-repository ppa:jonathonf/vim -y;
sudo apt-get -y update;
sudo apt-get install -y vim;
# neovim
sudo add-apt-repository ppa:neovim-ppa/unstable -y;
sudo apt-get install -y neovim;
# ssh
sudo apt-get remove -y openssh-client;
sudo apt-get install -y openssh-client;
sudo apt-get remove -y openssh-server;
sudo apt-get install -y openssh-server;
sudo ufw allow ssh;
sudo ufw status verbose;
sudo apt-get install -y net-tools;

# prolog
sudo add-apt-repository ppa:swi-prolog/stable;
sudo apt-get update -y;
sudo apt-get install -y swi-prolog;
# for vim coc prolog language server support
swipl -q -l "$this_path/../../../shared/scripts/prolog/install_language_server.pl";

# help address issues in shell scripts
sudo apt install shellcheck;

# golang
sudo apt-get install -y golang-go;

# java
sudo apt-get install -y openjdk-17-jdk openjdk-17-jre;
gradle_version='7.4.1';
wget https://services.gradle.org/distributions/gradle-${gradle_version}-bin.zip -P /tmp;
sudo unzip -d /opt/gradle /tmp/gradle-${gradle_version}-bin.zip;
sudo ln -s /opt/gradle/gradle-${gradle_version} /opt/gradle/latest;
sudo sed -E -i'' '/export PATH=\/opt\/gradle\/latest\/bin:\$\{PATH\}/d' /etc/profile.d/gradle.sh;
echo 'export PATH=/opt/gradle/latest/bin:${PATH}' | sudo tee /etc/profile.d/gradle.sh;
sudo chmod +x /etc/profile.d/gradle.sh;

# php
sudo add-apt-repository ppa:ondrej/php -y;
sudo apt install -y php8.0;
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";
php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;";
php composer-setup.php;
php -r "unlink('composer-setup.php');";
sudo mv composer.phar /usr/local/bin/composer;
rm composer.phar;

# nodejs nvm deps
sudo apt-get install -y build-essential checkinstall libssl-dev;
curl -Lk https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash;

# Adds microsoft packages to trusted hosts
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb;
sudo dpkg -i packages-microsoft-prod.deb;
sudo rm packages-microsoft-prod.deb;

# dotnet cli and deps
sudo apt-get -y install apt-transport-https;
sudo apt-get -y update;
sudo apt-get -y install dotnet-sdk-6.0;
dotnet tool install -g fsautocomplete;

# snapd for install packages
sudo apt-get -y install snapd;

# update pip
python -m pip install --upgrade pip;

# vim with clipboard support
sudo apt-get -y remove vim-common vim-runtime vim;
sudo apt-get -y install --upgrade vim-common vim-runtime vim;
sudo apt-get -y install vim-gtk;
# clipboard tool
sudo apt-get -y install xclip;
# clipboard manager, open its configs and make ctrl-` the Shortcuts -> Global -> Show the tray menu key
sudo apt-get -y install copyq;
# sound eq
sudo add-apt-repository ppa:mikhailnov/pulseeffects -y;
sudo apt-get -y update;
sudo apt-get -y install pulseeffects pulseaudio --install-recommends;

# docker
# from: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04
sudo apt-get -y remove docker docker-engine docker.io containerd runc;
sudo apt-get -y update;
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common;
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y;
sudo apt-get -y update;
apt-cache policy docker-ce;
sudo apt-get -y install docker-ce docker-ce-cli containerd.io;

# powershell
# Install pre-requisite packages.
sudo apt-get install -y wget apt-transport-https software-properties-common;
# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb;
# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb;
# Update the list of products
sudo apt-get -y update;
# Enable the "universe" repositories
sudo add-apt-repository universe -y;
# Install PowerShell
sudo apt-get install -y powershell;
# Cleanup
sudo rm packages-microsoft-prod.deb;

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
          -o /etc/bash_completion.d/docker-compose;

sudo apt-get -y upgrade;

# k8s: docker compose to k8s resources helper
curl -L https://github.com/kubernetes/kompose/releases/download/v1.26.0/kompose-linux-amd64 -o kompose
chmod +x kompose
sudo mv ./kompose /usr/local/bin/kompose

# k8s: minikube for runnning clusters locally
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# ruby
sudo apt-get install -y ruby-full;
sudo gem install solargraph;

