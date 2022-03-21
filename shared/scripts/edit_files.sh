#!/usr/bin/env bash

function edit_files {
  local temp="$1";
  local temp_shared="$2";
  local temp_this="$3";
  local edit_style="$4";

  shopt -s globstar;
  shopt -s dotglob;
  shopt -s nocasematch;
  shopt -s extglob;
  
  edit_files_helper "$temp_this/$edit_style/home/.bashrc.d/*" "$temp_shared/required/home/.bashrc.d" "$edit_style";
  edit_files_helper "$temp_this/$edit_style/home/.bash_completion.d/*" "$temp_shared/required/home/.bash_completion.d" "$edit_style";
  edit_files_helper "$temp_this/$edit_style/home/.zshrc.d/*" "$temp_shared/required/home/.zshrc.d" "$edit_style";
  edit_files_helper "$temp_this/$edit_style/home/.zsh_completion.d/*" "$temp_shared/required/home/.zsh_completion.d" "$edit_style";
  edit_files_helper "$temp_this/$edit_style/home/.bashrc.d/portable/*" "$temp_shared/required/home/.bashrc.d/portable" "$edit_style";
  edit_files_helper "$temp_this/$edit_style/home/*" "$temp_shared/required/home" "$edit_style";
  edit_files_helper "$temp_this/$edit_style/Tasks/*" "$temp_shared/required/Tasks" "$edit_style";
  edit_files_helper "$temp_this/$edit_style/vscodevim/*" "$temp_shared/required/vscodevim" "$edit_style";
}

function edit_files_helper {
  local dirGlob="$1";
  local destDir="$2";
  local estyle="$3";
  for i in $dirGlob ; do
    [[ -f "$i" ]] && {
      local b=$(basename "$i");
      [[ $estyle == "append" ]] && {
        # echo "cat \"$i\" >> \"$destDir/$b"
        # echo "rm \"$i\""
        cat "$i" >> "$destDir/$b";
        rm "$i";
      }
      [[ $estyle == "prepend" ]] && {
        # echo "cat <(cat \"$i\") <(cat \"$destDir/$b\") > \"$destDir/$b\""
        # echo "rm \"$i\""
        echo "$content" > "$destDir/$b";
        rm "$i";
      }
      [[ $estyle == "override" || $estyle == "new" ]] && {
        # echo "cat \"$i\" > \"$destDir/$b\""
        # echo "rm \"$i\""
        cat "$i" > "$destDir/$b";
        rm "$i";
      }
      [[ $estyle == "delete" ]] && {
        # echo "cat \"$i\" > \"$destDir/$b\""
        # echo "rm \"$i\""
        rm "$destDir/$b";
        rm "$i";
      }
    }
  done;
}

edit_files "$1" "$2" "$3" "$4";

