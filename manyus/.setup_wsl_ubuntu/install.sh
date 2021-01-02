sudo apt -y update
sudo apt -y upgrade
# session manager
sudo apt-get -y install tmux
# for cr formatting between dos and unix. gives dos2unix and unix2dos
sudo apt-get -y install dos2unix
# for clipboard support, note, that the clipboard support doesnt seem to work within wsl using this
# check vim clipboard with: vim --version | grep clipboard
# sudo apt-get -y install vim-gtk
# clipboard tool, NOT WORKING IN WSL
# sudo apt-get install xclip