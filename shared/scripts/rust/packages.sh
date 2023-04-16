#!/usr/bin/env bash

# query crates.io for crate details
# cargo install cargo-info

# ripgrep: grep
# du-dust: disk space util
# exa: ls
# bat: a cat clone with syntax highlighting; for colors in fzf preview
# irust: rust interactive
# nu: a new shell with types - like powershell
# starship: cross shell prompt
# zellij: tmux replacement
# bacon: rust code check - like shellcheck - integrates with lsp's
# cargo-watch: watcher for source code changes
# cargo-update: cargo install-update command
# cargo-outdated: cargo outdated command
# porsmo: timer
# gitui: git terminal gui
# wiki-tui: A simple and easy to use Wikipedia Text User Interface
# evcxr_jupyter: jupyter for rust
# rtx-cli: tool for managing programming language and tool versions - like asdf
# mprocs: simple tmux like watcher for long running processes
# sccache: speed up rust build times by cacheing libs and code that didnt change since last time
# bob-nvim: nvim version manager - doesnt allow for a global nvim. so all nvim versions must be managed by bob

function main {
  local method="$1"; method="${method:-"install"}";
  if [[ "$method" == "install" ]]; then
    cargo install cargo-update ripgrep du-dust exa bat sccache cargo-outdated;
  else
    # command from cargo-update package
    cargo install-update -a;
  fi
}

main $@;
