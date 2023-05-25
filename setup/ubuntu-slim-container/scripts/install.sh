#!/usr/bin/env sh

script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

export DEBIAN_FRONTEND=noninteractive;

this_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

apt-get -y update;
apt-get install -y software-properties-common;
# ensure basic system dependencies: from pyenv install steps: https://www.liquidweb.com/kb/how-to-install-pyenv-on-ubuntu-18-04/
apt-get install -y make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
  libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl \
  git;
# creates a 'python' and makes it point to python3 that is installed
apt-get -y install python-is-python3;
# for creating python virtual environments
apt-get -y install python3-venv;
# pyenv: python version manager
git clone https://github.com/pyenv/pyenv.git ~/.pyenv;
# ripgrep for vundle use or use on its own
add-apt-repository ppa:x4121/ripgrep -y;
apt-get -y update;
apt-get -y install ripgrep;
# fuzzy finder
# make sure this isnt around (its to old for the vim plugin)
apt-get -y remove fzf;
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf;
sed -E -i'' 's,curl -[^[:blank:]]+,curl -0Lk,g' ~/.fzf/install;
sed -E -i'' 's,(\s*\bask .*),#\1,' ~/.fzf/install;
sed -E -i'' 's,auto_completion=\$\?,true,' ~/.fzf/install;
sed -E -i'' 's,key_bindings=\$\?,true,' ~/.fzf/install;
~/.fzf/install;
# for Ag in vim
apt-get -y install silversearcher-ag;
# neovim
add-apt-repository ppa:neovim-ppa/unstable -y;
apt-get install -y neovim;

# help address issues in shell scripts
apt-get install -y shellcheck;

# golang
apt-get install -y golang-go;

# java
apt-get install -y openjdk-17-jdk openjdk-17-jre;
gradle_version='7.4.1';
wget https://services.gradle.org/distributions/gradle-${gradle_version}-bin.zip -P /tmp;
unzip -d /opt/gradle /tmp/gradle-${gradle_version}-bin.zip;
ln -s /opt/gradle/gradle-${gradle_version} /opt/gradle/latest;
sed -E -i'' '/export PATH=\/opt\/gradle\/latest\/bin:\$\{PATH\}/d' /etc/profile.d/gradle.sh;
echo 'export PATH=/opt/gradle/latest/bin:${PATH}' | tee -a /etc/profile.d/gradle.sh;
chmod +x /etc/profile.d/gradle.sh;

# php
add-apt-repository ppa:ondrej/php -y;
apt install -y php8.0;
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php;
php -r "unlink('composer-setup.php');";
mv composer.phar /usr/local/bin/composer;
rm composer.phar;

# nodejs nvm deps
apt-get install -y build-essential checkinstall libssl-dev;
curl -Lk https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash;

# Adds microsoft packages to trusted hosts
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb;
dpkg -i packages-microsoft-prod.deb;
rm packages-microsoft-prod.deb;

# dotnet cli and deps
apt-get -y install apt-transport-https;
apt-get -y update;
apt-get -y install dotnet-sdk-6.0;
dotnet tool install -g fsautocomplete;

# snapd for install packages
apt-get -y install snapd;

# update pip
python -m pip install --upgrade pip;

apt-get -y upgrade;

# ruby
apt-get install -y ruby-full;
gem install solargraph;
