#!/usr/bin/env sh

script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

export DEBIAN_FRONTEND=noninteractive;

this_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

sudo apt-get -y update;
sudo apt-get install -y software-properties-common;
# ensure basic system dependencies: from pyenv install steps: https://www.liquidweb.com/kb/how-to-install-pyenv-on-ubuntu-18-04/
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
  libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl \
  git;
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
# neovim
sudo add-apt-repository ppa:neovim-ppa/unstable -y;
sudo apt-get install -y neovim;

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
sudo apt install -y php8.0;
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
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

sudo apt-get -y upgrade;

# ruby
sudo apt-get install -y ruby-full;
sudo gem install solargraph;
