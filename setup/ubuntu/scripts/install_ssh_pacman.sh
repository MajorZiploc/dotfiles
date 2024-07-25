#!/usr/bin/env bash

# NOTE: UNTESTED

this_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

# pacman: online search tool for packages https://archlinux.org/packages/
# Core and Extra repositories seem to be used alot in these packages

sudo pacman -Syu --noconfirm;
sudo pacman -S --noconfirm base-devel;
# ensure basic system dependencies: from pyenv install steps: https://www.liquidweb.com/kb/how-to-install-pyenv-on-ubuntu-18-04/
sudo pacman -S --noconfirm make gcc openssl zlib bzip2 readline sqlite wget curl llvm ncurses tk libffi xz;
# session manager
sudo pacman -S --noconfirm tmux;
# for cr formatting between dos and unix. gives dos2unix and unix2dos
sudo pacman -S --noconfirm dos2unix;
# json query for cli
sudo pacman -S --noconfirm jq;
# yaml query for cli
sudo pacman -S --noconfirm yq;
# creates a 'python' and makes it point to python3 that is installed
sudo pacman -S --noconfirm python;
# for creating python virtual environments
sudo pacman -S --noconfirm python-virtualenv;
# pyenv: python version manager
# git clone https://github.com/pyenv/pyenv.git ~/.pyenv;
curl https://pyenv.run | bash;
# ripgrep for vundle use or use on its own
sudo pacman -S --noconfirm ripgrep;
# fuzzy finder
# make sure this isnt around (its to old for the vim plugin)
sudo pacman -Rns --noconfirm fzf;
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf;
sed -E -i'' 's,curl -[^[:blank:]]+,curl -0Lk,g' ~/.fzf/install;
sed -E -i'' 's,(\s*\bask .*),#\1,' ~/.fzf/install;
sed -E -i'' 's,auto_completion=\$\?,true,' ~/.fzf/install;
sed -E -i'' 's,key_bindings=\$\?,true,' ~/.fzf/install;
~/.fzf/install;
# for Ag in vim
sudo pacman -S --noconfirm the_silver_searcher;
# zsh
sudo pacman -S --noconfirm zsh;
# neovim
sudo pacman -S --noconfirm neovim;

# help address issues in shell scripts
sudo pacman -S --noconfirm shellcheck;

# nodejs nvm deps
sudo pacman -S --noconfirm nodejs npm;

# update pip
python -m pip install --upgrade pip;

sudo pacman -Syu --noconfirm;

