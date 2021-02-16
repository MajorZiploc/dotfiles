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

# SET OPERATIONS BEGIN
# Referenced https://catonmat.net/set-operations-in-unix-shell

# set operations
set_elem() {
  # membership check. ex: grep -xs 'element' set
  # returns 1 if set contains element, 0 if not
  # $ele = $1
  # $set = $2
  grep -xq "$1" $2
}

set_eq() {
  # check if sets are equal
  # $ diff -q <(sort A | uniq) <(sort B | uniq)
  # return code 1 -- sets A and B are not equal

  # $ diff -q <(sort Aequal | uniq) <(sort Bequal | uniq)
  # return code 0 -- sets A and B are equal
  
  # $set1 = $1
  # $set2 = $2
  diff -q <(sort $1 | uniq) <(sort $2 | uniq)
}

set_cardinality() {
  # the number of elements in the set
  # $set = $1 = $file
  sort -u $1 | wc -l
}

set_subset() {
  # test if $1 is a subset of $2
  # $subset = $1
  # $superset = $2
  # comm returns no output if $subset is a subset of $superset
  # comm outputs something if $subset is not a subset of $superset
  [[ -z $(comm -23 <(sort $1 | uniq) <(sort $2 | uniq) | head -1) ]]
}

set_union () {
  # returns elements that occur in either sets or both sets
  # $set1 = $1
  # $set2 = $2
  sort -u $1 $2
}

set_intersection() {
  # returns elements that occur in both sets
  # $set1 = $1
  # $set2 = $2
  comm -12 <(sort $1) <(sort $2)
}


set_complement() {
  # returns elements that occur in $1 and not in $2
  # $1 - $2
  # $set1 = $1
  # $set2 = $2
  comm -23 <(sort $1) <(sort $2)
}

set_symmetric_difference() {
  # returns elements that occur in either set, but not both sets
  # $set1 = $1
  # $set2 = $2
  sort $1 $2 | uniq -u
}

set_power_set_experimental() {
  # EXPERIMENTAL!
  # returns a set that contains all subsets of the set
  # $set1 = $1
  perl -le '
  sub powset {
   return [[]] unless @_;
   my $head = shift;
   my $list = &powset;
   [@$list, map { [$head, @$_] } @$list]
  }
  chomp(my @e = <>);
  for $p (@{powset(@e)}) {
   print @$p;
  }' $1
}

set_cardesian_product_experimental() {
  # EXPERIMENTAL!
  # returns a set that contains all possible pairs of elements from one set and the other
  # $1 x $2
  # $set1 = $1
  # $set2 = $2
  while read a; do while read b; do echo "$a, $b"; done < $1; done < $2
}

set_disjoint_experimental() {
  # EXPERIMENTAL!
  # The disjoint set test operation finds if two sets are disjoint, i.e., they do not contain common elements.
  # $set1 = $1
  # $set2 = $2
  # returns 0 if sets are disjoint
  # returns 1 if sets are not disjoint
  awk '{ if (++seen[$0]==2) exit 1 }' $1 $2
}

set_minimum() {
  # $set1 = $1
  head -1 <(sort $1)
}

set_minimum_num() {
  # $set1 = $1
  head -1 <(sort -n $1)
}

set_maximum() {
  # $set1 = $1
  tail -1 <(sort $1)
}

set_maximum_num() {
  # $set1 = $1
  tail -1 <(sort -n $1)
}

# SET OPERATIONS END

prefix_file() {
  local text=$1
  local file=$2
  sed -i "1s/^/$text/" "$file"
}

function col {
  # Extract the nths column from a tabular output
  local n=$1
  awk -v col=$n '{print $col}'
}

function skip {
  # Skip first x words in line
  local n=$(($1 + 1))
  cut -d' ' -f$n-
}

function first {
  # Keep first x words in line
  local n=$1
  cut -d' ' -f1-$n
}

