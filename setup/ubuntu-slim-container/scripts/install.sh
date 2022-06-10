#!/usr/bin/env sh

script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )";

export DEBIAN_FRONTEND=noninteractive;

apt-get -y update;

apt-get install -y software-properties-common;

# vim 8.2
add-apt-repository ppa:jonathonf/vim -y;
apt-get -y update;
apt-get install -y vim;

# nodejs nvm deps
# apt-get install -y build-essential checkinstall libssl-dev;
# curl -Lk https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash;

apt-get -y upgrade;

