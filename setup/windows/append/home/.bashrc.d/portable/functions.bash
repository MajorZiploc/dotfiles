function cmd_exec {
  # executes command prompt commands or file
  local command="$1";
  [[ -z "$command" ]] && { echo "Must specify command parameter\!" >&2; return 1; }
  cmd.exe "/c $command";
}

function mssql_exec {
  local server="$1";
  local database="$2";
  local sql_cmd="$3";
  local column_separator_char="$4";
  [[ -z "$server" ]] && { echo "Must specify a server\!" >&2; return 1; }
  [[ -z "$database" ]] && { echo "Must specify a database\!" >&2; return 1; }
  [[ -z "$sql_cmd" ]] && { echo "Must specify a sql_cmd file or string\!" >&2; return 1; }
  echo "${column_separator_char:=","}" >/dev/null;
  if [[ -e "$sql_cmd" ]]; then
    sqlcmd.exe -S "$server" -E -i "$sql_cmd" -d "$database" -W -s "$column_separator_char";
  else
    sqlcmd.exe -S "$server" -E -Q "$sql_cmd" -d "$database" -W -s "$column_separator_char";
  fi
}

function mssql_exec_clean {
  mssql_exec "$@" | egrep -v "(^\W+$|\([[:digit:]]+ rows affected\))";
}

function mssql_exec_delimiter_count_single_line {
  local sql_result=`mssql_exec "$@"`;
  csv_delimiter_check_single_line "$sql_result" "$4";
}

