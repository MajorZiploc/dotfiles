#!/usr/bin/env bash

this_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

flags="$1";
[[ -z "$flags" ]] && { flags='0'; }
flags_as_int="$((2#$flags))";
full_install="$((2#1))";

softwareupdate --all --install --force;

# instal xcode
xcode-select --install;

# pre brew

# node
mkdir ~/.nvm;

# rust
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh;

if [[ $(($full_install & $flags_as_int)) == $full_install ]]; then
  # brew update;
  cp "$this_path/Brewfile" "$HOME/";
else
  # brew update;
  echo "$(cat "$this_path/Brewfile" | sed -E "s,(.*\# full_install)$,# \\1,g")" > "$HOME/Brewfile";
fi
( cd "$HOME/" || return 1; brew bundle; )

# post brew
export NVM_DIR=~/.nvm;
source "$(brew --prefix nvm)/nvm.sh";
nvm install node;

pyenv install 3.11.2;
pyenv global 3.11.2;

[[ $(($full_install & $flags_as_int)) == $full_install ]] && {
  # for vim coc prolog language server support
  swipl -q -l "$this_path/../../../shared/scripts/prolog/install_language_server.pl";

  # golang
  # bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer);
  # . ~/.gvm/scripts/gvm;
  # gvm install go1.18;
  # gvm use go1.18;

  # php
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";
  php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
  php composer-setup.php;
  php -r "unlink('composer-setup.php');";
  sudo mv composer.phar /usr/local/bin/composer;
  rm composer.phar;

  # ruby deps
  sudo gem install solargraph;

  # k8s: minikube for runnning clusters locally
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-arm64
  sudo install minikube-darwin-arm64 /usr/local/bin/minikube
  rm minikube-darwin-arm64;
}

"$this_path/set_preferences.sh";
