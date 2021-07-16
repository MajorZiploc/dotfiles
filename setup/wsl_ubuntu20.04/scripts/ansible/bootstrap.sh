#!/bin/bash

# Current directory of this script.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function ensure_pip {
    if command -v pip 2>/dev/null; then
        echo "Pip already exists. Skipping."
        return
    else
        echo "Installing pip"
        curl https://bootstrap.pypa.io/get-pip.py > /tmp/get-pip.py
        sudo python3 /tmp/get-pip.py
        rm /tmp/get-pip.py
    fi
}

# Run from script directory
cd $DIR

echo "Obtaining root privileges"
sudo true
echo "Root privileges obtained"

# Make sure we have a working pip.
ensure_pip

# Install ansible
# Will upgrade if already installed.
sudo pip install -U ansible[azure]

echo "Passing control to ansible"
# Making double sure we have permissions to run as root.
# Alternative is to use the `--ask-become-pass` option,
# but that will ask *every* time, not only if needed.
sudo true
ansible-playbook dev.yml

RED='\033[0;31m'
NC='\033[0m' # No Color]]'
echo -e "${RED}"
echo -e "Reload your shell environment to load new configuration."
echo -e "If in tmux, you may need to restart the server."
echo -e "${NC}"
