#!/usr/bin/env bash

sed -E -i'' 's/(vim.cmd \{ cmd = "TSInstall", args = missing, bang = true \})/-- \1/g' ~/.local/share/lunarvim/lvim/lua/lvim/core/treesitter.lua;
