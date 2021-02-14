h() {
  if [ -z "$1" ]; then history; else history | tail -n $1; fi
}

tmuxns() {
  if [ -z "$1" ]; then
    session_name=$(basename $(pwd))
    tmux new -s "$session_name"
    history;
  else
    tmux new -s "$1";
  fi
}

ide1() {
  tmux split-window -v -p 30
}

ide2() {
  tmux split-window -v -p 30
  tmux split-window -h -p 55
}

ide3() {
  tmux split-window -v -p 30
  tmux split-window -h -p 66
  tmux split-window -h -p 50
}

show_find_full_paths() {
  find $1 -exec readlink -f {} \;
}

show_machine_details() {
  user=$(whoami)
  machine_name=$(uname -n)
  long_info=$(uname -a)
  echo "user: $user"
  echo "machine_name: $machine_name"
  echo "long_info: $long_info"
}

show_folder_details() {
  total_items=$(ls -A | wc -l)
  total_dirs=$(ls -Al | egrep "^d" | wc -l)
  total_files=$(ls -Al | egrep "^-" | wc -l)
  nonhidden_items=$(ls | wc -l)
  nonhidden_dirs=$(ls -l | egrep "^d" | wc -l)
  nonhidden_files=$(ls -l | egrep "^-" | wc -l)
  hidden_items=$(($total_items - $nonhidden_items))
  hidden_dirs=$(($total_dirs - $nonhidden_dirs))
  hidden_files=$(($total_files - $nonhidden_files))
  git_branch=$(__git_ps1)
  echo "$PWD"
  echo "format: nonhidden/hidden/total"
  echo "items: $nonhidden_items/$hidden_items/$total_items"
  echo "dirs: $nonhidden_dirs/$hidden_dirs/$total_dirs"
  echo "files: $nonhidden_files/$hidden_files/$total_files"
  echo "git_branch:$git_branch"
}


# set operations
set_elem() {
  # EXPERIMENTAL!
  # membership check. ex: grep -xs 'element' set
  # returns 1 if set contains element, 0 if not
  # $ele = $1
  # $set = $2
  grep -xc $1 $2
}

set_eq() {
  # EXPERIMENTAL!
  # $ diff -q <(sort A | uniq) <(sort B | uniq)
  # return code 1 -- sets A and B are not equal

  # $ diff -q <(sort Aequal | uniq) <(sort Bequal | uniq)
  # return code 0 -- sets A and B are equal
  
  # $set1 = $1
  # $set2 = $2
  diff -q <(sort $1 | uniq) <(sort $2 | uniq)
}

set_cardinality() {
  # EXPERIMENTAL!
  # $set = $1 = $file
  sort -u $1 | wc -l
}

