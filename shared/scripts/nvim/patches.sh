#!/usr/bin/env bash

function csharp_issues {
  file_path="/usr/share/nvim/runtime/ftplugin/cs.lua"
  prepend_text="-- Check if 'undo_ftplugin' exists and initialize it if nil
  if vim.b.undo_ftplugin == nil then
      vim.b.undo_ftplugin = \"\"
  end
  "
  tmp_file=$(mktemp)
  echo "$prepend_text" > "$tmp_file"
  cat "$file_path" >> "$tmp_file"
  sudo mv "$tmp_file" "$file_path"
  # Ensure proper file permissions (optional)
  # sudo chmod 644 "$file_path"
  sudo -k;
}

function main {
  csharp_issues;
}

main;
