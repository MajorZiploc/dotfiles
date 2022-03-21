#!/usr/bin/env zsh

sh -c "$(curl -0Lk https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting;

