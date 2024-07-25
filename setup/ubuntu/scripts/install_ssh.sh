#!/usr/bin/env bash

this_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

sudo apt-get -y update;
sudo apt-get install -y software-properties-common;
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
sudo apt-get -y install yq;
# creates a 'python' and makes it point to python3 that is installed
sudo apt-get -y install python-is-python3;
# for creating python virtual environments
sudo apt-get -y install python3-venv;
# pyenv: python version manager
# git clone https://github.com/pyenv/pyenv.git ~/.pyenv;
curl https://pyenv.run | bash;
# ripgrep for vundle use or use on its own
sudo add-apt-repository ppa:x4121/ripgrep -y;
sudo apt-get -y update;
sudo apt-get -y install ripgrep;
# fuzzy finder
# make sure this isnt around (its to old for the vim plugin)
sudo apt-get -y remove fzf;
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf;
sed -E -i'' 's,curl -[^[:blank:]]+,curl -0Lk,g' ~/.fzf/install;
sed -E -i'' 's,(\s*\bask .*),#\1,' ~/.fzf/install;
sed -E -i'' 's,auto_completion=\$\?,true,' ~/.fzf/install;
sed -E -i'' 's,key_bindings=\$\?,true,' ~/.fzf/install;
~/.fzf/install;
# for Ag in vim
sudo apt-get -y install silversearcher-ag;
# zsh
sudo apt-get install -y zsh;
# neovim
sudo add-apt-repository ppa:neovim-ppa/unstable -y;
sudo apt-get install -y neovim;

# help address issues in shell scripts
sudo apt-get install -y shellcheck;

# nodejs nvm deps
sudo apt-get install -y build-essential checkinstall libssl-dev;
curl -Lk https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash;

# snapd for install packages
sudo apt-get -y install snapd;

# update pip
python -m pip install --upgrade pip;

sudo apt-get -y upgrade;

