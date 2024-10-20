function cmd_exec {
  # executes command prompt commands or file
  local command="$1";
  [[ -z "$command" ]] && { echo "Must specify command parameter" >&2; return 1; }
  cmd.exe "/c $command";
}

function mssql_exec {
  local server="$1";
  local database="$2";
  local sql_cmd="$3";
  local column_separator_char="$4";
  [[ -z "$server" ]] && { echo "Must specify a server" >&2; return 1; }
  [[ -z "$database" ]] && { echo "Must specify a database" >&2; return 1; }
  [[ -z "$sql_cmd" ]] && { echo "Must specify a sql_cmd file or string" >&2; return 1; }
  echo "${column_separator_char:=","}" >/dev/null;
  if [[ -e "$sql_cmd" ]]; then
    sqlcmd.exe -S "$server" -E -i "$sql_cmd" -d "$database" -W -s "$column_separator_char";
  else
    sqlcmd.exe -S "$server" -E -Q "$sql_cmd" -d "$database" -W -s "$column_separator_char";
  fi
}

function mssql_exec_clean {
  mssql_exec "$@" |  grep -Ev "(^\W+$|\([[:digit:]]+ rows affected\))";
}

function mssql_exec_delimiter_count_single_line {
  local sql_result; sql_result=$(mssql_exec "$@");
  csv_delimiter_check_single_line "$sql_result" "$4";
}

function cdws {
  export HOMEWS=`find /mnt/c/Users/ -mindepth 1 -maxdepth 1 -type d | fzf`;
  echo "$HOMEWS" > ~/.windows_side_home;
  cd "$HOMEWS";
}

function cdwh {
  if [[ -z "$HOMEWS" ]]; then
    cdws;
  else
    cd "$HOMEWS";
  fi
}

# requires ilspycmd.exe and .net6 to be installed on the windows side
function decompile_dlls_and_exes_ilspycmd {
  local folder_to_decompile="$1";
  local output_folder_in_windows_absolute_path_style="$2";
  [[ -z "$folder_to_decompile" ]] && { echo "Must specify folder_to_decompile" >&2; return 1; }
  [[ -z "$output_folder_in_windows_absolute_path_style" ]] && { echo "Must specify output_folder_in_windows_absolute_path_style" >&2; return 1; }
  mkdir -p "$output_folder_in_windows_absolute_path_style";
  find "${folder_to_decompile}" -regextype egrep -iregex ".*\.(dll|exe)" -type f -print0 | while read -d $'\0' file; do
    win_file=$(realpath "$file" | sed -E 's,^/home,//wsl.localhost/Ubuntu/home,;s,^/mnt,,;s,^/(\w)/,\U\1:/,g;');
    d=`basename "$file" | sed -E 's,(\S+)\.(dll|exe),\1_\2,'`;
    powershell.exe -c "ilspycmd.exe $win_file" > "${output_folder_in_windows_absolute_path_style}/$d.cs";
    echo "Done with $win_file";
  done;
}

function decompile_dlls_and_exes_just_decompile {
  local folder_to_decompile="$1";
  local output_folder_in_windows_absolute_path_style="$2";
  # JustDecompile location on windows
  # /mnt/c/Program Files (x86)/Progress/JustDecompile/Libraries/JustDecompile.exe
  [[ -z "$folder_to_decompile" ]] && { echo "Must specify folder_to_decompile" >&2; return 1; }
  [[ -z "$output_folder_in_windows_absolute_path_style" ]] && { echo "Must specify output_folder_in_windows_absolute_path_style" >&2; return 1; }
  mkdir -p "$output_folder_in_windows_absolute_path_style";
  find "${folder_to_decompile}" -regextype egrep -iregex ".*\.(dll|exe)" -type f -print0 | while read -d $'\0' file; do
    win_file=`realpath "$file" | sed -E "s,^/(\w)/,\U\1:/,g"`;
    d=`basename "$file" | sed -E 's,(\S+)\.(dll|exe),\1_\2,'`;
    cmd.exe "/c JustDecompile.exe /out:${output_folder_in_windows_absolute_path_style}/$d /target:$win_file";
    echo "Done with $win_file";
  done;
}

function type_info_for_cs_ilspycmd {
  local folder_with_decompiled_content="$1";
  local output_folder="$2";
  [[ -z "$folder_with_decompiled_content" ]] && { echo "Must specify folder_with_decompiled_content" >&2; return 1; }
  [[ -z "$output_folder" ]] && { echo "Must specify output_folder" >&2; return 1; }
  mkdir -p "$output_folder";
  find "${folder_with_decompiled_content}" -regextype egrep -iregex ".*" -type d -print0 | while read -d $'\0' folder; do
    abs_folder_name=`realpath "$folder"`;
    base_folder_name=`basename "$folder"`;
    find "$abs_folder_name" -regextype egrep -iregex ".*\.cs" -type f -not -path '*/.git/*' -not -path '*/.svn/*' -not -path '*/node_modules/*' -not -path '*/.venv/*' -exec egrep --color -in -e "\b(private|internal|public|class|enum|interface)\b" "{}" + > "${output_folder}/${base_folder_name}.cs";
  done;
}

function type_info_for_cs_just_decompile {
  local folder_with_decompiled_content="$1";
  local output_folder="$2";
  [[ -z "$folder_with_decompiled_content" ]] && { echo "Must specify folder_with_decompiled_content" >&2; return 1; }
  [[ -z "$output_folder" ]] && { echo "Must specify output_folder" >&2; return 1; }
  mkdir -p "$output_folder";
  find "${folder_with_decompiled_content}" -regextype egrep -iregex ".*(dll|exe)" -type d -print0 | while read -d $'\0' folder; do
    abs_folder_name=`realpath "$folder"`;
    base_folder_name=`basename "$folder"`;
    find "$abs_folder_name" -regextype egrep -iregex ".*\.cs" -type f -not -path '*/.git/*' -not -path '*/.svn/*' -not -path '*/node_modules/*' -not -path '*/.venv/*' -exec egrep --color -in -e "\b(private|internal|public|class|enum|interface)\b" "{}" + > "${output_folder}/${base_folder_name}.cs";
  done;
}

