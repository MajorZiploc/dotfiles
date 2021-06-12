#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

@test "check bash content to make sure _PLACEHOLDER doesnt exist in the files" {
files=`find ~ -maxdepth 1 -regextype egrep -iregex ".*bash.*" -type f`;
for file in ${files[@]};
  do
    run grep "_PLACEHOLDER" "$file";
    assert_failure
    assert_output ""
  done;

}

@test "check home vim content to make sure _PLACEHOLDER doesnt exist in the files" {
  files=`find ~ -maxdepth 1 -regextype egrep -iregex ".*vim.*" -type f`;
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

@test "check tasks to make sure _PLACEHOLDER doesnt exist in the files" {
  files=`find ~/Tasks -maxdepth 1 -type f`;
  for file in ${files[@]};
    do
      run grep "_PLACEHOLDER" "$file";
      assert_failure
      assert_output ""
    done;
}

@test "check clipboard files to make sure _PLACEHOLDER doesnt exist" {
  files=`find ~/clipboard -type f`;
  for file in ${files[@]};
    do
      run grep "_PLACEHOLDER" "$file";
      assert_failure
      assert_output ""
    done;
}

@test "check vscode files to make sure _PLACEHOLDER doesnt exist" {
  files=`find ~/.config/Code/User -type f`;
  for file in ${files[@]};
    do
      run grep "_PLACEHOLDER" "$file";
      assert_failure
      assert_output ""
    done;
}

@test "check home bin files to make sure _PLACEHOLDER doesnt exist" {
  files=`find ~/bin -type f`;
  for file in ${files[@]};
    do
      run grep "_PLACEHOLDER" "$file";
      assert_failure
      assert_output ""
    done;
}

