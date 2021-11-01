#!/usr/bin/env zsh

. ~/.zshrc_core

# install rust
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

# install rust analyzer
# linux - first solution worked. might have to launch into bash first when in a rust project
# git clone https://github.com/rust-analyzer/rust-analyzer.git;
# cd rust-analyzer;
# cargo xtask install --server;
# cd ..;
# rm -rf rust-analyzer;
#
# OR
#
# sudo snap install rust-analyzer --beta
#
# mac
# brew install rust-analyzer

