#!/usr/bin/env bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
# source brew in current session
export PATH="/opt/homebrew/bin/brew shellenv:$PATH";
eval "$(/opt/homebrew/bin/brew shellenv)"
