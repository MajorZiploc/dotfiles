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
sudo apt-get -y install nodejs
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