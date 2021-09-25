# vim: set filetype=bash :

parse-bash-function-aliases:
  #!/usr/bin/env bash
  aliases=`cat ./shared/required/home/.bashrc.d/functions* | egrep "function\s*[[:alpha:]]" | sed -E 's/function (\w+).*/\1/;s/([[:alpha:]])[[:alpha:]]+_/\1:/g;s/([[:alpha:]])[[:alpha:]]+/\1/g;s/(.*)/_\1/g;s/(.*)/alias \1/g' | tr -d ":"`;
  function_names=`cat ./shared/required/home/.bashrc.d/functions*.bash | egrep "function\s*[[:alpha:]]" | sed -E 's/function\s*([a-zA-Z0-9_-]+?).*/\1/;s/(.*)/"\1"/g'`;
  paste -d= <(echo "$aliases") <(echo "$function_names");

