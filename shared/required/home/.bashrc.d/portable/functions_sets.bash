function set_elem {
  # membership check.
  # returns 1 if set contains element, 0 if not
  local ele=$1;
  local set=$2;
  grep -xq "$ele" $set;
}

function set_eq {
  # check if sets are equal
  # return code 1 -- sets A and B are not equal
  # return code 0 -- sets A and B are equal
  local set1=$1;
  local set2=$2;
  diff -q <(sort -u $set1) <(sort -u $set2);
}

function set_cardinality {
  # the number of elements in the set
  local set=$1;
  sort -u $set | wc -l;
}

function set_is_subset {
  # test if $1 is a subset of $2
  local subset=$1;
  local superset=$2;
  # comm returns no output if $subset is a subset of $superset
  # comm outputs something if $subset is not a subset of $superset
  [[ -z $(comm -23 <(sort -u $1) <(sort -u $2) | head -1) ]]
}

function set_union {
  # returns elements that occur in either sets or both sets
  local set1=$1;
  local set2=$2;
  sort -u $set1 $set2;
}

function set_intersection {
  # returns elements that occur in both sets
  local set1=$1;
  local set2=$2;
  comm -12 <(sort -u $set1) <(sort -u $set2) | sort -u;
}

function set_difference {
  # returns elements that occur in $1 and not in $2
  # $1 - $2
  local set1=$1;
  local set2=$2;
  comm -23 <(sort -u $set1) <(sort -u $set2);
}

function set_symmetric_difference {
  # returns elements that occur in either set, but not both sets
  local set1=$1;
  local set2=$2;
  sort <(sort -u $set1) <(sort -u $set2) | uniq -u;
}

function set_are_disjoint {
  # The disjoint set test operation finds if two sets are disjoint, i.e., they do not contain common elements.
  local set1=$1;
  local set2=$2;
  # returns 0 if sets are disjoint
  # returns 1 if sets are not disjoint
  awk '{ if (++seen[$0]==2) exit 1 }' $set1 $set2;
}

function set_minimum {
  local set=$1;
  head -1 <(sort $set);
}

function set_minimum_num {
  local set=$1;
  head -1 <(sort -n $set);
}

function set_maximum {
  local set=$1;
  tail -1 <(sort $set);
}

function set_maximum_num {
  local set=$1;
  tail -1 <(sort -n $set);
}
