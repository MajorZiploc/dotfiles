#!/usr/bin/env bash

function edit_files {
  local temp="$1"
  local tempShared="$2"
  local tempThis="$3"
  local edit_style="$4"

  shopt -s globstar
  shopt -s dotglob
  shopt -s nocasematch
  shopt -s extglob
  
  edit_files_helper "$tempThis/$edit_style/home/.bashrc.d/*" "$tempShared/required/home/.bashrc.d" "$edit_style"
  edit_files_helper "$tempThis/$edit_style/home/.bash_completion.d/*" "$tempShared/required/home/.bash_completion.d" "$edit_style"
  edit_files_helper "$tempThis/$edit_style/home/.zshrc.d/*" "$tempShared/required/home/.zshrc.d" "$edit_style"
  edit_files_helper "$tempThis/$edit_style/home/.zsh_completion.d/*" "$tempShared/required/home/.zsh_completion.d" "$edit_style"
  edit_files_helper "$tempThis/$edit_style/home/.bashrc.d/portable/*" "$tempShared/required/home/.bashrc.d/portable" "$edit_style"
  edit_files_helper "$tempThis/$edit_style/home/*" "$tempShared/required/home" "$edit_style"
  edit_files_helper "$tempThis/$edit_style/Tasks/*" "$tempShared/required/Tasks" "$edit_style"
  edit_files_helper "$tempThis/$edit_style/vscodevim/*" "$tempShared/required/vscodevim" "$edit_style"
}

function edit_files_helper {
  local dirGlob="$1"
  local destDir="$2"
  local estyle="$3"
  for i in $dirGlob ; do
    [[ -f "$i" ]] && {
      local b=$(basename "$i");
      [[ $estyle == "append" ]] && {
        # echo "cat \"$i\" >> \"$destDir/$b"
        # echo "rm \"$i\""
        cat "$i" >> "$destDir/$b"
        rm "$i"
      }
      [[ $estyle == "prepend" ]] && {
        # echo "cat <(cat \"$i\") <(cat \"$destDir/$b\") > \"$destDir/$b\""
        # echo "rm \"$i\""
        echo "$content" > "$destDir/$b"
        rm "$i"
      }
      [[ $estyle == "override" || $estyle == "new" ]] && {
        # echo "cat \"$i\" > \"$destDir/$b\""
        # echo "rm \"$i\""
        cat "$i" > "$destDir/$b"
        rm "$i"
      }
      [[ $estyle == "delete" ]] && {
        # echo "cat \"$i\" > \"$destDir/$b\""
        # echo "rm \"$i\""
        rm "$destDir/$b"
        rm "$i"
      }
    }
  done;
}

edit_files "$1" "$2" "$3" "$4"

