#!/usr/bin/env zsh

. "$HOME/.zshrc_core";
. "$HOME/Tasks/workplace_bulk_ops.sh";

function nothing {
  true;
}

function main {
  local microsoft_dev_tools="$HOME/dev/microsoft";
  local chrome_debugger_dir="${microsoft_dev_tools}/vscode-chrome-debug";
  local node_debugger_dir="${microsoft_dev_tools}/vscode-node-debug2";
  local git_repos=("$chrome_debugger_dir" "$node_debugger_dir" "$HOME/.fzf" "$HOME/.local/share/lunarvim/lvim");
  for git_repo in ${git_repos[@]}; do
    cd "$git_repo" || continue;
    project_operation 'nothing' '' 'n';
  done;
}

main
