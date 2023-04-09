#!/usr/bin/env bash

this_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

# This block is all fine
pkg install root-repo;
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

# TODO: verifty fzf works here
# fuzzy finder
# make sure this isnt around (its to old for the vim plugin)
pkg remove -y fzf;
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf;
sed -E -i'' 's,curl -[^[:blank:]]+,curl -0Lk,g' ~/.fzf/install;
~/.fzf/install;

# for Ag in vim
pkg install -y silversearcher-ag;

pkg install -g nodejs;
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash;
