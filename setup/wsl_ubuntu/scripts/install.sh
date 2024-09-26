#!/usr/bin/env bash

this_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

sudo apt-get -y update;
# ensure basic system dependencies: from pyenv install steps: https://www.liquidweb.com/kb/how-to-install-pyenv-on-ubuntu-18-04/
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
  libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev git;
# add this to above if needed python-openssl
# session manager
sudo apt-get -y install tmux;
# for cr formatting between dos and unix. gives dos2unix and unix2dos
sudo apt-get -y install dos2unix;
# json query for cli
sudo apt-get -y install jq;
# yaml query for cli
sudo add-apt-repository ppa:rmescandon/yq -y;
sudo apt-get -y update;
sudo apt-get -y install yq;
# view directories in tree format
sudo apt-get -y install tree;
# for clipboard support in vim
sudo apt-get -y install xclip;

# ctags
sudo apt-get -y install universal-ctags;
# references for ctags
sudo apt-get -y install cscope;

# creates a 'python' and makes it point to python3 that is installed
sudo apt-get -y install python-is-python3;
# for gui support for matplotlib
sudo apt-get install python3-tk;
# OR you can use this pip library in your project
# pip install pyqt5
# pyenv: python version manager
# git clone https://github.com/pyenv/pyenv.git ~/.pyenv;
curl https://pyenv.run | bash;
# ripgrep for vundle use or use on its own
sudo apt-get -y install ripgrep;
# fuzzy finder
# make sure this isnt around (its to old for the vim plugin)
sudo apt-get -y remove fzf;
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf;
sed -E -i'' 's,curl -[^[:blank:]]+,curl -0Lk,g' ~/.fzf/install;
~/.fzf/install;
# for Ag in vim
sudo apt-get -y install silversearcher-ag;
# google chrome
sudo apt-get install -y curl unzip xvfb libxi6 libgconf-2-4;
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb;
sudo apt-get install -y ./google-chrome-stable_current_amd64.deb;
sudo rm ./google-chrome-stable_current_amd64.deb;
# google driver
wget https://chromedriver.storage.googleapis.com/86.0.4240.22/chromedriver_linux64.zip;
unzip chromedriver_linux64.zip;
sudo mv chromedriver /usr/bin/chromedriver;
sudo chown root:root /usr/bin/chromedriver;
sudo chmod +x /usr/bin/chromedriver;
sudo rm -rf chromedriver_linux64.zip;
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
# latex
sudo apt install texlive-latex-extra

# prolog
sudo add-apt-repository ppa:swi-prolog/stable -y;
sudo apt-get update -y;
sudo apt-get install -y swi-prolog;
# for vim coc prolog language server support
swipl -q -l "$this_path/../../../shared/scripts/prolog/install_language_server.pl";

# help address issues in shell scripts
sudo apt-get install -y shellcheck;

# golang
sudo apt-get install -y golang-go;

# java
sudo apt-get install -y openjdk-17-jdk openjdk-17-jre;
gradle_version='7.4.1';
wget https://services.gradle.org/distributions/gradle-${gradle_version}-bin.zip -P /tmp;
sudo unzip -d /opt/gradle /tmp/gradle-${gradle_version}-bin.zip;
sudo ln -s /opt/gradle/gradle-${gradle_version} /opt/gradle/latest;
sudo sed -E -i'' '/export PATH=\/opt\/gradle\/latest\/bin:\$\{PATH\}/d' /etc/profile.d/gradle.sh;
echo 'export PATH=/opt/gradle/latest/bin:${PATH}' | sudo tee -a /etc/profile.d/gradle.sh;
sudo chmod +x /etc/profile.d/gradle.sh;

# php
sudo add-apt-repository ppa:ondrej/php -y;
sudo apt-get install -y php8.0;
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php;
php -r "unlink('composer-setup.php');";
sudo mv composer.phar /usr/local/bin/composer;
rm composer.phar;

# install nvm for nodejs
sudo apt-get install -y build-essential checkinstall libssl-dev;
curl -Lk https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash;

# Adds microsoft packages to trusted hosts
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb;
sudo dpkg -i packages-microsoft-prod.deb;
sudo rm packages-microsoft-prod.deb;

# dotnet cli and deps
sudo apt-get install -y apt-transport-https;
sudo apt-get -y update;
# sudo apt-get install -y dotnet-sdk-3.1;
# sudo apt-get install -y dotnet-sdk-6.0;
sudo apt-get install -y dotnet-sdk-8.0;

# snapd
sudo apt-get -y install snapd;

# just command runner
sudo snap install just --edge --classic;

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

# update pip
python -m pip install --upgrade pip;

# installs extra packages for google chrome, needed for automation tools like puppeteer js
sudo apt-get -y update \
  && sudo apt-get install -y wget gnupg \
  && sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && sudo apt-get -y update \
  && sudo apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
  --no-install-recommends #\
      # not sure why this is recommended to do for extra packages of google chrome
    #&& sudo rm -rf /var/lib/apt/lists/*

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
