#!/usr/bin/env bash

# KEY:
# - a '#' means its part of my extended vscode flow
# - a '##' means it is something i would like to look into
# - a '###' means it is an alternative

# Core plugings
# vim emulation
code --install-extension vscodevim.vim
# fall back vim emulation
### code --install-extension asvetliakov.vscode-neovim
# checks spelling
code --install-extension streetsidesoftware.code-spell-checker
# color codes csv columns
code --install-extension mechatroner.rainbow-csv
# code formatter for js/ts/html/json
code --install-extension esbenp.prettier-vscode
# advanced git actions
code --install-extension eamodio.gitlens
# a graph for git
code --install-extension mhutchie.git-graph

# Core-Extended plugings
# gives a table view for data, dont recommend using it to edit data
# code --install-extension janisdd.vscode-edit-csv
# See through glass feel 
# code --install-extension s-nlf-fh.glassit
# Simple tmux key binds for the vscode terminal
# code --install-extension stephlin.vscode-tmux-keybinding
# rest api client - postman like
## code --install-extension humao.rest-client

# docker
# run project inside the container
code --install-extension ms-vscode-remote.remote-containers
# code --enable-proposed-api ms-vscode-remote.remote-containers
code --install-extension ms-azuretools.vscode-docker

# dotnet
# base language support
code --install-extension Ionide.Ionide-fsharp
# base language support
code --install-extension ms-dotnettools.csharp
# base language support
code --install-extension ms-vscode.powershell

# Python
# base language support
code --install-extension ms-python.python
# intellisense
code --install-extension ms-python.vscode-pylance
## code --install-extension ms-toolsai.jupyter
# run on save/edit
# code --install-extension almenon.arepl

# godot
# code --install-extension geequlim.godot-tools

# Java
# code --install-extension vscjava.vscode-java-pack

# javascript / typescript
# run on save/edit
## code --install-extension wallabyjs.quokka-vscode
## prettier typescript error blocks
code --install-extension yoavbls.pretty-ts-errors

# bash wsl
# run inside ubuntu wsl container
# code --install-extension ms-vscode-remote.remote-wsl
# debug bash code
# code --install-extension rogalmic.bash-debug

# sql formatter
# code --install-extension adpyke.vscode-sql-formatter

# mssql
# code --install-extension ms-mssql.mssql

# postgres
# code --install-extension ckolkman.vscode-postgres

# general non mssql database connection
## code --install-extension bajdzis.vscode-database

# prolog
# base language support
# code --install-extension arthurwang.vsc-prolog

