#!/usr/bin/env bash

# KEY:
# - a '#' means its part of my extended vscode flow
# - a '##' means it is something i would like to look into
# - a '###' means it is an alternative

vscodes=();
if which code >/dev/null 2>&1; then
  vscodes+=("code")
fi
if which code-insiders >/dev/null 2>&1; then
  vscodes+=("code-insiders")
fi

echo "vscodes to install plugins for: ${vscodes[*]}";

for vscode in ${vscodes[@]}; do
  # Core plugings
  # vim emulation
  eval "$vscode --install-extension vscodevim.vim"
  # fall back vim emulation
  ### code --install-extension asvetliakov.vscode-neovim
  # background images
  # eval "$vscode --install-extension katsute.code-background"
  # checks spelling
  eval "$vscode --install-extension streetsidesoftware.code-spell-checker"
  # color codes csv columns
  eval "$vscode --install-extension mechatroner.rainbow-csv"
  # code formatter for js/ts/html/json
  eval "$vscode --install-extension esbenp.prettier-vscode"
  # advanced git actions
  eval "$vscode --install-extension eamodio.gitlens"
  # a graph for git
  eval "$vscode --install-extension mhutchie.git-graph"
  # fzf and rg support
  eval "$vscode --install-extension tomrijndorp.find-it-faster"
  # markdown mermaid support
  eval "$vscode --install-extension bierner.markdown-mermaid"

  # Core-Extended plugings
  # gives a table view for data, dont recommend using it to edit data
  # eval "$vscode --install-extension janisdd.vscode-edit-csv"
  # See through glass feel 
  # eval "$vscode --install-extension s-nlf-fh.glassit"
  # Simple tmux key binds for the vscode terminal
  # eval "$vscode --install-extension stephlin.vscode-tmux-keybinding"
  # rest api client - postman like
  ## eval "$vscode --install-extension humao.rest-client"

  # docker
  # run project inside the container
  eval "$vscode --install-extension ms-vscode-remote.remote-containers"
  # eval "$vscode --enable-proposed-api ms-vscode-remote.remote-containers"
  eval "$vscode --install-extension ms-azuretools.vscode-docker"

  # dotnet
  # base language support
  eval "$vscode --install-extension Ionide.Ionide-fsharp"
  # base language support
  eval "$vscode --install-extension ms-dotnettools.csharp"
  # base language support
  eval "$vscode --install-extension ms-vscode.powershell"

  # Python
  # base language support
  eval "$vscode --install-extension ms-python.python"
  # intellisense
  eval "$vscode --install-extension ms-python.vscode-pylance"
  ## eval "$vscode --install-extension ms-toolsai.jupyter"
  # run on save/edit
  # eval "$vscode --install-extension almenon.arepl"

  # godot
  # eval "$vscode --install-extension geequlim.godot-tools"

  # Java
  # eval "$vscode --install-extension vscjava.vscode-java-pack"

  # javascript / typescript
  # run on save/edit
  ## eval "$vscode --install-extension wallabyjs.quokka-vscode"
  ## prettier typescript error blocks
  # eval "$vscode --install-extension yoavbls.pretty-ts-errors"

  # bash wsl
  # run inside ubuntu wsl container
  # eval "$vscode --install-extension ms-vscode-remote.remote-wsl"
  # debug bash code
  # eval "$vscode --install-extension rogalmic.bash-debug"

  # sql formatter
  # eval "$vscode --install-extension adpyke.vscode-sql-formatter"

  # mssql
  # eval "$vscode --install-extension ms-mssql.mssql"

  # postgres
  # eval "$vscode --install-extension ckolkman.vscode-postgres"

  # general non mssql database connection
  ## eval "$vscode --install-extension bajdzis.vscode-database"

  # prolog
  # base language support
  # eval "$vscode --install-extension arthurwang.vsc-prolog"
done;
