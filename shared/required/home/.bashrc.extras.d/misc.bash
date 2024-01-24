function show_folder_details {
  local total_items=`ls -A | wc -l`;
  local total_dirs=`ls -Al | grep -E "^d" | wc -l`;
  local total_files=`ls -Al | grep -E "^-" | wc -l`;
  local nonhidden_items=`ls | wc -l`;
  local nonhidden_dirs=`ls -l | grep -E "^d" | wc -l`;
  local nonhidden_files=`ls -l | grep -E "^-" | wc -l`;
  local hidden_items=$(($total_items - $nonhidden_items));
  local hidden_dirs=$(($total_dirs - $nonhidden_dirs));
  local hidden_files=$(($total_files - $nonhidden_files));
  local git_branch=`__git_ps1`;
  echo "$PWD";
  echo "format: nonhidden/hidden/total";
  echo "items: $nonhidden_items/$hidden_items/$total_items";
  echo "dirs: $nonhidden_dirs/$hidden_dirs/$total_dirs";
  echo "files: $nonhidden_files/$hidden_files/$total_files";
  echo "git_branch:$git_branch";
}

function prefix_file {
  # add a line to the beginning of a file
  # $1: string to add
  # $2: file
  local text="$1";
  local file="$2";
  [[ -z "$text" ]] && { echo "Must specify text" >&2; return 1; }
  [[ -z "$file" ]] && { echo "Must specify file" >&2; return 1; }
  sed -i "1s/^/$text/" "$file";
}

function sample {
  # get a random sample of lines from a file or std out
  # Note: the lines retain order relative to each other
  # $1: pos num
  # $2: file/stdout
  local n="$1";
  local content="$2";
  [[ -z "$n" ]] && { echo "Must specify n" >&2; return 1; }
  [[ -z "$content" ]] && { echo "Must specify content" >&2; return 1; }
  shuf -n "$n" $content;
}

function sample_csv {
  # grab a random sample of n size from a csv
  local n="$1";
  local file="$2";
  cat <(head -n 1 "$file") <(sample "$n" <(tail -n +2 "$file"));
}

