#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

check="check";
placeholder="_PLACEHOLDER"
phdoesntexist="files to make sure $placeholder doesnt exist"

@test "$check bash $phdoesntexist" {
files=`find ~ -maxdepth 1 -regextype egrep -iregex ".*bash.*" -type f`;
for file in ${files[@]};
  do
    run grep "_PLACEHOLDER" "$file";
    assert_failure
    assert_output ""
  done;
}

@test "$check home vim $phdoesntexist" {
  files=`find ~ -maxdepth 1 -regextype egrep -iregex ".*vim.*" -type f`;
  for file in ${files[@]};
    do
      [[ $file =~ .*\.viminfo ]] || {
        run grep "_PLACEHOLDER" "$file";
        assert_failure
        assert_output ""
      }
    done;
}

@test "$check vim plugin $phdoesntexist" {
  files=`find ~/vimfiles/plugin-settings -maxdepth 1 -type f`;
  for file in ${files[@]};
    do
      run grep "_PLACEHOLDER" "$file";
      assert_failure
      assert_output ""
    done;
}

@test "$check tasks $phdoesntexist" {
  files=`find ~/Tasks -maxdepth 1 -type f`;
  for file in ${files[@]};
    do
      run grep "_PLACEHOLDER" "$file";
      assert_failure
      assert_output ""
    done;
}

@test "$check clipboard $phdoesntexist" {
  files=`find ~/clipboard -type f`;
  for file in ${files[@]};
    do
      run grep "_PLACEHOLDER" "$file";
      assert_failure
      assert_output ""
    done;
}

@test "$check vscode $phdoesntexist" {
  files=`find ~/.config/Code/User -type f`;
  for file in ${files[@]};
    do
      run grep "_PLACEHOLDER" "$file";
      assert_failure
      assert_output ""
    done;
}

@test "$check home bin $phdoesntexist" {
  files=`find ~/bin -type f`;
  for file in ${files[@]};
    do
      run grep "_PLACEHOLDER" "$file";
      assert_failure
      assert_output ""
    done;
}

