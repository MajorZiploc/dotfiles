#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

@test "check bash content to make sure _PLACEHOLDER doesnt exist in the files" {
files=(
  "$HOME/.bash_profile"
  "$HOME/.bashrc"
  "$HOME/.bash_env_vars"
  "$HOME/.bash_functions"
)
for file in ${files[@]};
  do

    run grep "_PLACEHOLDER" "$file";
    assert_failure
    assert_output ""
  done;

}

@test "check home vim content to make sure _PLACEHOLDER doesnt exist in the files" {
  files=(
  "$HOME/_commonvimrc"
  "$HOME/_vimrcterm"
  "$HOME/_vim_plugins"
  "$HOME/.vimrc"
  )
  for file in ${files[@]};
    do

      run grep "_PLACEHOLDER" "$file";
      assert_failure
      assert_output ""
    done;
}

@test "check vim plugin config content to make sure _PLACEHOLDER doesnt exist in the files" {
  files=`find ~/vimfiles/plugin-settings -maxdepth 1 -type f`;
  for file in ${files[@]};
    do

      run grep "_PLACEHOLDER" "$file";
      assert_failure
      assert_output ""
    done;
}

