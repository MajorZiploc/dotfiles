function snip_sql_column_view_fn_info {
  # choices: ["none", "low", "high"]
  local sql_flavor="$1";
  local constraint_details="$2";
  local view_details="$3";
  local fn_details="$4";
  if [[ "${sql_flavor}" == "sqlite" ]]; then
    echo "SELECT name, '\"' || sql || '\"' as sql
FROM sqlite_master
WHERE type = 'table'
AND name NOT LIKE 'sqlite_%';";
    return 0;
  fi
  constraint_details="${constraint_details:-"high"}";
  view_details="${view_details:-"low"}";
  fn_details="${fn_details:-"none"}";
  local table_access_modifier="";
  [[ "${sql_flavor}" == "mssql" ]] && { table_access_modifier=" WITH(NOLOCK)"; }
  sql_comment="-- ";
  local table_name_filter="";
  [[ "${sql_flavor}" == "pgsql" ]] && {
    table_name_filter="t.TABLE_NAME NOT LIKE '_pg_%'
      AND t.TABLE_NAME NOT LIKE 'pg_%'
      -- AND t.TABLE_NAME NOT LIKE 'sql_%'
      -- AND t.TABLE_NAME NOT LIKE 'routine_%'";
  }
  local constraint_filter="t.CONSTRAINT_TYPE LIKE '%KEY%'";

  local constraints_sub_query="";
  if [[ "${constraint_details}" != "none" ]]; then
    local constraints_sub_query="
UNION
    SELECT
    'constraint' as ENTRY_TYPE
    , t.TABLE_NAME
    , t.CONSTRAINT_NAME as ENTRY_NAME
    , t.CONSTRAINT_TYPE as DATA_TYPE
    , '' as IS_NULLABLE
    , 0 as CHARACTER_MAXIMUM_LENGTH
    , 0 as NUMERIC_PRECISION
    , 0 as DATETIME_PRECISION
    , kcu.COLUMN_NAME as COLUMN_DEFAULT
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS t${table_access_modifier}
    LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu${table_access_modifier}
      ON t.constraint_name = kcu.constraint_name
    WHERE
      ${constraint_filter}${table_name_filter:+"
      AND $table_name_filter"}";
  fi

  local view_sub_query="";
  if [[ "${view_details}" != "none" ]]; then
    local low_detail_prefix="";
    [[ "${view_details}" != "low" ]] && { low_detail_prefix="${sql_comment}"; }
    local high_detail_prefix="";
    [[ "${view_details}" != "high" ]] && { high_detail_prefix="${sql_comment}"; }
    local view_def="${high_detail_prefix}, t.VIEW_DEFINITION AS DATA_TYPE -- use if you want to see the view definitions - chunky";
    view_def+="
    ${low_detail_prefix}, '' AS DATA_TYPE -- use if you want to minify this query - minify";
    local view_sub_query="
UNION
    SELECT
    'view' AS ENTRY_TYPE
    , t.TABLE_NAME
    , '' AS ENTRY_NAME
    ${view_def}
    , '' as IS_NULLABLE
    , 0 as CHARACTER_MAXIMUM_LENGTH
    , 0 as NUMERIC_PRECISION
    , 0 as DATETIME_PRECISION
    , '' as COLUMN_DEFAULT
    FROM INFORMATION_SCHEMA.VIEWS AS t${table_access_modifier}${table_name_filter:+"
    WHERE
      $table_name_filter"}
";
  fi

  local function_sub_query="";
  if [[ "${fn_details}" != "none" ]]; then
    if [[ "${sql_flavor}" == "mysql" || "${sql_flavor}" == "mariadb" ]]; then
      echo "-- WARNING: ${sql_flavor} does not support function sub query! Will not be included in resulting query";
    else
      local low_detail_prefix="";
      [[ "${fn_details}" != "low" ]] && { low_detail_prefix="${sql_comment}"; }
      local high_detail_prefix="";
      [[ "${fn_details}" != "high" ]] && { high_detail_prefix="${sql_comment}"; }
      fn_def="${high_detail_prefix}, r.ROUTINE_DEFINITION AS DATA_TYPE -- use if you want to see the function definitions - chunky";
      fn_def+="
      ${low_detail_prefix}, '' AS DATA_TYPE -- use if you want to minify this query - minify";
      function_sub_query="
  UNION
      SELECT
      lower(r.ROUTINE_TYPE) AS ENTRY_TYPE
      , 'zzz' AS TABLE_NAME -- zzz to push function to the end of the sort
      , r.SPECIFIC_NAME AS ENTRY_NAME
      ${fn_def}
      , '' as IS_NULLABLE
      , 0 as CHARACTER_MAXIMUM_LENGTH
      , 0 as NUMERIC_PRECISION
      , 0 as DATETIME_PRECISION
      , '' as COLUMN_DEFAULT
      FROM INFORMATION_SCHEMA.ROUTINES AS r${table_access_modifier}
      FULL OUTER JOIN INFORMATION_SCHEMA.PARAMETERS AS p${table_access_modifier}
        ON p.SPECIFIC_NAME = r.SPECIFIC_NAME
      WHERE
        r.ROUTINE_TYPE IS NOT NULL";
    fi
  fi

  local rest=${constraints_sub_query}${function_sub_query}${view_sub_query};
  local _command="
SELECT
'column' as ENTRY_TYPE
, t.TABLE_NAME
, t.COLUMN_NAME as ENTRY_NAME
, t.DATA_TYPE
, t.IS_NULLABLE
, t.CHARACTER_MAXIMUM_LENGTH
, t.NUMERIC_PRECISION
, t.DATETIME_PRECISION
, t.COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS AS t${table_access_modifier}${table_name_filter:+"
WHERE $table_name_filter"}${rest}";
  local order_by="ORDER BY TABLE_NAME, ENTRY_TYPE, ENTRY_NAME";
if [[ -z "$rest" ]]; then
  _command+="
";
fi
  _command+="$order_by
;";
  echo "$_command";
}

function snip_sql_search_general {
  local snip; snip=`cat << EOF
/* SQL general search, NOT FOR COLUMNS */
SELECT
name AS [Name],
SCHEMA_NAME(schema_id) AS schema_name,
type_desc,
create_date,
modify_date
FROM sys.objects -- WITH(NOLOCK) -- mssql
WHERE name LIKE '%Pattern%'
AND type ='u'
;
EOF
`;
  echo "$snip";
}

function snip_pwsh_init_module {
  local snip; snip=`cat << EOF
pwsh -Command '& {Set-StrictMode -Version 3; Import-Module powershell_scaffolder; Initialize-Module -Path ./ -ModuleName "test" -Author "Manyu Lakhotia" -Description "Test powershell module" -ModuleVersion "0.0.1" -PowershellVersion "5.1" -CompanyName "N/A" -CopyRight "N/A";}'
EOF
`;
  echo "$snip";
}

function snip_pwsh_init_script {
  local snip; snip=`cat << EOF
pwsh -Command '& {Set-StrictMode -Version 3; Import-Module powershell_scaffolder; Initialize-Script -Path ./ -ScriptName "test" -ShouldUseAdvLogging $false}'
EOF
`;
  echo "$snip";
}

function snip_bash_for_loop {
echo '
OLDIFS=$IFS;
IFS=$'"'\\\\n'"';
l=(1 2 3 "4");
for ele in ${l[@]}; do
  echo "$ele" hi;
done;
IFS=$OLDIFS;
';
}

function snip_bash_while {
echo '
echo "$eles" | while read -r -d $'"'\\\\n'"' ele; do
  echo "$ele hi";
done;
';
}

function snip_bash_while_stream {
echo '
while read -r -d $'"'\\\\n'"' ele; do
  echo "$ele hi";
done < <(echo "$eles");
';
}

function snip_log {
  local lang="$1";
  local log_statement="echo";
  local var_name="thing";
  local append=";";
  if [[ "$lang" == "sh" ]]; then
    echo "$log_statement \"$var_name\"$append";
    echo "$log_statement $var_name$append";
    return 0;
  elif [[ "$lang" == "js" ]]; then
    log_statement="console.log";
  elif [[ "$lang" == "py" ]]; then
    log_statement="print";
    append="";
  elif [[ "$lang" == "java" ]]; then
    log_statement="System.out.println";
  elif [[ "$lang" == "cs" ]]; then
    log_statement="Console.WriteLine";
  elif [[ "$lang" == "fs" ]]; then
    log_statement="printfn \"$var_name: %A\"";
    append="";
    echo "$log_statement $var_name$append";
    return 0;
  fi
  echo "$log_statement(\"$var_name\")$append";
  echo "$log_statement($var_name)$append";
}
