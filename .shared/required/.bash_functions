h() {
  # show history
  # $1: optional pos num to show last n entries in the history
  local n=$1
  [[ -z "$n" ]] && { n=25; }
  history | tail -n $n;
}

tmuxns() {
  # creates a tmux session
  # $1: optional string to represent name of the tmux session
  # If $1 not given, then use the base name of the path as the session name
  if [ -z "$1" ]; then
    session_name=$(basename $(pwd))
    tmux new -s "$session_name"
    history;
  else
    tmux new -s "$1";
  fi
}

ide1() {
  # splits the window into 2 panes
  tmux split-window -v -p 30
}

ide2() {
  # splits the window into 3 panes
  tmux split-window -v -p 30
  tmux split-window -h -p 55
}

ide3() {
  # splits the window into 4 panes
  tmux split-window -v -p 30
  tmux split-window -h -p 66
  tmux split-window -h -p 50
}

show_find_full_paths() {
  # displays the full path names of $1 (the directory)
  # $1: optional directory. Defaults to .
  find $1 -exec readlink -f {} \;
}

show_machine_details() {
  local user=$(whoami)
  local machine_name=$(uname -n)
  long_info=$(uname -a)
  echo "user: $user"
  echo "machine_name: $machine_name"
  echo "long_info: $long_info"
}

show_folder_details() {
  local total_items=$(ls -A | wc -l)
  local total_dirs=$(ls -Al | egrep "^d" | wc -l)
  local total_files=$(ls -Al | egrep "^-" | wc -l)
  local nonhidden_items=$(ls | wc -l)
  local nonhidden_dirs=$(ls -l | egrep "^d" | wc -l)
  local nonhidden_files=$(ls -l | egrep "^-" | wc -l)
  local hidden_items=$(($total_items - $nonhidden_items))
  local hidden_dirs=$(($total_dirs - $nonhidden_dirs))
  local hidden_files=$(($total_files - $nonhidden_files))
  local git_branch=$(__git_ps1)
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
  local ele=$1
  local set=$2
  grep -xq "$ele" $set
}

set_eq() {
  # check if sets are equal
  # $ diff -q <(sort A | uniq) <(sort B | uniq)
  # return code 1 -- sets A and B are not equal

  # $ diff -q <(sort Aequal | uniq) <(sort Bequal | uniq)
  # return code 0 -- sets A and B are equal
  
  local set1=$1
  local set2=$2
  diff -q <(sort $set1 | uniq) <(sort $set2 | uniq)
}

set_cardinality() {
  # the number of elements in the set
  local set=$1
  sort -u $set | wc -l
}

set_subset() {
  # test if $1 is a subset of $2
  local subset=$1
  local superset=$2
  # comm returns no output if $subset is a subset of $superset
  # comm outputs something if $subset is not a subset of $superset
  [[ -z $(comm -23 <(sort $1 | uniq) <(sort $2 | uniq) | head -1) ]]
}

set_union () {
  # returns elements that occur in either sets or both sets
  local set1=$1
  local set2=$2
  sort -u $set1 $set2
}

set_intersection() {
  # returns elements that occur in both sets
  local set1=$1
  local set2=$2
  comm -12 <(sort $set1) <(sort $set2)
}


set_complement() {
  # returns elements that occur in $1 and not in $2
  # $1 - $2
  local set1=$1
  local set2=$2
  comm -23 <(sort $set1) <(sort $set2)
}

set_symmetric_difference() {
  # returns elements that occur in either set, but not both sets
  local set1=$1
  local set2=$2
  sort $set1 $set2 | uniq -u
}

set_power_set_experimental() {
  # EXPERIMENTAL!
  # returns a set that contains all subsets of the set
  local set=$1
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
  }' $set
}

set_cardesian_product_experimental() {
  # EXPERIMENTAL!
  # returns a set that contains all possible pairs of elements from one set and the other
  # $1 x $2
  local set1=$1
  local set2=$2
  while read a; do while read b; do echo "$a, $b"; done < $set1; done < $set2
}

set_disjoint_experimental() {
  # EXPERIMENTAL!
  # The disjoint set test operation finds if two sets are disjoint, i.e., they do not contain common elements.
  local set1=$1
  local set2=$2
  # returns 0 if sets are disjoint
  # returns 1 if sets are not disjoint
  awk '{ if (++seen[$0]==2) exit 1 }' $set1 $set2
}

set_minimum() {
  local set=$1
  head -1 <(sort $set)
}

set_minimum_num() {
  local set=$1
  head -1 <(sort -n $set)
}

set_maximum() {
  local set=$1
  tail -1 <(sort $se1)
}

set_maximum_num() {
  local set=$1
  tail -1 <(sort -n $set)
}

# SET OPERATIONS END

prefix_file() {
  # add a line to the beginning of a file
  # $1: string to add
  # $2: file
  local text=$1
  local file=$2
  sed -i "1s/^/$text/" "$file"
}

function col {
  # Extract the nths column from a tabular output
  # $1: pos num
  local n=$1
  awk -v col=$n '{print $col}'
}

function skip {
  # Skip first n words in line
  # $1: pos num
  local n=$(($1 + 1))
  cut -d' ' -f$n-
}

function first {
  # Keep first n words in line
  # $1: pos num
  local n=$1
  cut -d' ' -f1-$n
}

function sample {
  # get a random sample of lines from a file or std out
  # Note: the lines retain order relative to each other
  # $1: pos num
  # $2: file/stdout
  local n="$1"
  local content="$2"
  shuf -n "$n" $content
}

function show_file_content {
  # displays file contents lead by the name of the file
  # files=$@
  tail -n +1 $@
}

function sample_csv {
  # grab a random sample of n size from a csv
  local n=$1
  local file="$2"
  cat <(head -n 1 "$file") <(sample $n <(tail -n +2 "$file"))
}

function search_env_for {
  # searches through bash env and user defined bash tools
  local search_regex="";
  [[ -z "$1" ]] && { search_regex=".*"; } || { search_regex="$1"; }
  cat <(ls -A ~/bin 2> /dev/null) <(ls -A /usr/local/bin 2> /dev/null) <(alias) <(env) <(declare -F) <(shopt) | egrep -i "$search_regex"
}

