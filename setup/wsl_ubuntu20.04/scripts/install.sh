sudo apt -y update
# session manager
sudo apt-get -y install tmux
# for cr formatting between dos and unix. gives dos2unix and unix2dos
sudo apt-get -y install dos2unix
# view directories in tree format
sudo apt-get -y install tree
# creates a 'python' and makes it point to python3 that is installed
sudo apt-get -y install python-is-python3
# installs python package manager
sudo apt-get -y install pipenv
# installs nodejs
# sudo apt-get -y install nodejs
# installs npm
# sudo apt-get -y install npm
# ripgrep for vundle use or use on its own
sudo apt-get install ripgrep
# fuzzy finder
sudo apt-get install fzf

# install nvm for nodejs
sudo apt install -y build-essential checkinstall libssl-dev
curl -o- HTTPS://raw.githubusercontent.com/creationix/nvm/v0.35.1/install.sh | bash

# Adds microsoft packages to trusted hosts
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

# dotnet cli and deps
sudo apt-get install -y apt-transport-https
sudo apt-get update
sudo apt-get install -y dotnet-sdk-5.0

# update pip
python -m pip install --upgrade pip
# install python project scaffolder
pip install pyscaffold
pip install pyscaffoldext-django
# Should be installed in the projects virtual env for tox support
# pip install testresources
# pip install tox

# for clipboard support, note, that the clipboard support doesnt seem to work within wsl using this
# check vim clipboard with: vim --version | grep clipboard
# sudo apt-get -y install vim-gtk
# clipboard tool, NOT WORKING IN WSL
# sudo apt-get install xclip

sudo apt -y upgrade

# copy contents of source to existing dir dest, including hidden stuff
# cp -a /source/. /dest/

# shows full path of files in current directory recursively, -- NOTE, you can use other find flags to filter this like normal
# find . -exec readlink -f {} \;
