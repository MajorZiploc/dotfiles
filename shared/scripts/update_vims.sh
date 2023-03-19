#!/usr/bin/env bash

# NOTE: NOT PERFECT - THERE IS NO GOOD WAY TO KNOW WHEN A COMMAND IS DONE. SO A CHAIN OF COMMANDS LIKE THIS MAY NOT WORK

function main {
  if which lvim; then
    lvim "+:PackerInstall" "+:PackerUpdate" 2>/dev/null;
  fi
  if which nvim; then
    nvim "+:PlugInstall" "+:PlugUpgrade" "+:PlugUpdate" "+:CocInstall" "+:CocUpdate" 2>/dev/null;
  fi
  if which vim; then
    vim "+:PlugInstall" "+:PlugUpgrade" "+:PlugUpdate" "+:CocInstall" "+:CocUpdate" 2>/dev/null;
  fi
}

main
