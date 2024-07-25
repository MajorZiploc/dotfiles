#!/usr/bin/env bash

# NOTE: UNTESTED
# NOTE: COPIED STRAIGHT FROM CHATGPT WITHOUT EDITS

this_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

# NOTE: yum is an rpm wrapper

sudo yum -y update;
sudo yum install -y epel-release;
# ensure basic system dependencies: from pyenv install steps: https://www.liquidweb.com/kb/how-to-install-pyenv-on-ubuntu-18-04/
sudo yum install -y make gcc openssl-devel zlib-devel bzip2 bzip2-devel readline-devel sqlite-devel wget curl llvm ncurses-devel tk-devel libffi-devel xz;
# session manager
sudo yum install -y tmux;
# for cr formatting between dos and unix. gives dos2unix and unix2dos
sudo yum install -y dos2unix;
# json query for cli
sudo yum install -y jq;
# yaml query for cli
sudo yum install -y yq;
# creates a 'python' and makes it point to python3 that is installed
sudo yum install -y python3;
# for creating python virtual environments
sudo yum install -y python3-virtualenv;
# pyenv: python version manager
# git clone https://github.com/pyenv/pyenv.git ~/.pyenv;
curl https://pyenv.run | bash;
# ripgrep for vundle use or use on its own
sudo yum install -y ripgrep;
# fuzzy finder
# make sure this isnt around (its to old for the vim plugin)
sudo yum remove -y fzf;
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf;
sed -E -i'' 's,curl -[^[:blank:]]+,curl -0Lk,g' ~/.fzf/install;
sed -E -i'' 's,(\s*\bask .*),#\1,' ~/.fzf/install;
sed -E -i'' 's,auto_completion=\$\?,true,' ~/.fzf/install;
sed -E -i'' 's,key_bindings=\$\?,true,' ~/.fzf/install;
~/.fzf/install;
# for Ag in vim
sudo yum install -y the_silver_searcher;
# zsh
sudo yum install -y zsh;
# neovim
sudo yum install -y neovim;

# help address issues in shell scripts
sudo yum install -y ShellCheck;

# nodejs nvm deps
sudo yum install -y nodejs npm;

# snapd for install packages
sudo yum install -y snapd;

# update pip
sudo python3 -m pip install --upgrade pip;

sudo yum -y upgrade;

