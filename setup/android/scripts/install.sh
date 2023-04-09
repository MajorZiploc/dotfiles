#!/usr/bin/env bash

this_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

pkg -y update;
# session manager
pkg -y install tmux;
# for cr formatting between dos and unix. gives dos2unix and unix2dos
pkg -y install dos2unix;
# fuzzy finder
# make sure this isnt around (its to old for the vim plugin)
pkg -y remove fzf;
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf;
sed -E -i'' 's,curl -[^[:blank:]]+,curl -0Lk,g' ~/.fzf/install;
~/.fzf/install;
# for Ag in vim
pkg -y install silversearcher-ag;
# ssh
pkg remove -y openssh-client;
pkg install -y openssh-client;
pkg remove -y openssh-server;
pkg install -y openssh-server;
ufw allow ssh;
ufw status verbose;
pkg install -y net-tools;

# update pip
python -m pip install --upgrade pip;

# vim with clipboard support
pkg -y remove vim-common vim-runtime vim;
pkg -y install --upgrade vim-common vim-runtime vim;
pkg -y install vim-gtk;
