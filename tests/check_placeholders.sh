#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc 2>/dev/null || true;

check="check";
placeholder="_PLACEHOLDER"
phdoesntexist="files to make sure $placeholder doesnt exist"

function check_for_placeholder {
  for file in $@;
    do
      [[ $file =~ .*\.viminfo ]] || {
        run grep "_PLACEHOLDER" "$file";
        assert_failure
        assert_output ""
      }
    done;
}

@test "$check bash $phdoesntexist" {
  files=(
    ~/.bash_profile
    ~/.bashrc
  )
  check_for_placeholder $files;
  files=`find ~/.bashrc.d -maxdepth 1 -iname "*vim*" -type f`;
  check_for_placeholder $files;
}

@test "$check home vim $phdoesntexist" {
  files=`find ~ -maxdepth 1 -iname "*vim*" -type f`;
  check_for_placeholder $files;
}

@test "$check vim plugin $phdoesntexist" {
  files=`find ~/.vim/plugin-settings -maxdepth 1 -type f`;
  check_for_placeholder $files;
}

@test "$check tasks $phdoesntexist" {
  files=`find ~/Tasks -maxdepth 1 -type f`;
  check_for_placeholder $files;
}

@test "$check clipboard $phdoesntexist" {
  files=`find ~/clipboard -type f`;
  check_for_placeholder $files;
}

@test "$check vscode $phdoesntexist" {
  vscode_dir="$HOME/AppData/Roaming/Code/User"
  [[ -f "$vscode_dir" ]] || {
    vscode_dir="$HOME/.config/Code/User"
  }
  [[ -f "$vscode_dir" ]] || {
    # TODO: verify that space in the path doesnt impact the check_for_placeholder check of files later on
    vscode_dir="$HOME/Library/Application Support/Code/User"
  }
  files=`find "$vscode_dir" -maxdepth 1 -type f -iname "*.json"`;
  check_for_placeholder $files;
}

@test "$check home bin $phdoesntexist" {
  files=`find ~/bin -type f`;
  check_for_placeholder $files;
}

