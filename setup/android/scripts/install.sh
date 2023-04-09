#!/usr/bin/env bash

this_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

pkg install root-repo;
pkg install -y x11-repo;
pkg upgrade;
pkg update -y;
# session manager
pkg install -y tmux;
# for cr formatting between dos and unix. gives dos2unix and unix2dos
pkg install -y dos2unix;
pkg install -y git;
# vim
pkg install -y vim-python;
# neovim
pkg install -y neovim;
pkg install -y zsh;
pkg install -y shellcheck;
pkg install -y xclip;
pkg install -y ripgrep;
pkg install -y fzf;

# for Ag in vim
pkg install -y silversearcher-ag;

pkg install -y nodejs;
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash;

pkg install -y openssh;

