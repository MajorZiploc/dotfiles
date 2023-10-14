function snip_sql_column_view_fn_info {
  # choices: ["none", "low", "high"]
  local constraint_details="$1";
  local view_details="$2";
  local fn_details="$3";
  constraint_details="${constraint_details:-"high"}";
  view_details="${view_details:-"low"}";
  fn_details="${fn_details:-"none"}";
  sql_comment="-- ";

  local constraints_sub_query="";
  if [[ "${constraint_details}" != "none" ]]; then
    local constraints_sub_query="
UNION
    SELECT
    'constraint' as ENTRY_TYPE
    , tc.TABLE_NAME
    , tc.CONSTRAINT_NAME as ENTRY_NAME
    , tc.CONSTRAINT_TYPE as DATA_TYPE
    , '' as IS_NULLABLE
    , 0 as CHARACTER_MAXIMUM_LENGTH
    , 0 as NUMERIC_PRECISION
    , 0 as DATETIME_PRECISION
    , kcu.COLUMN_NAME as COLUMN_DEFAULT
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc -- WITH(NOLOCK)
    LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu ON tc.constraint_name = kcu.constraint_name
    WHERE tc.CONSTRAINT_TYPE LIKE '%KEY%'
      AND tc.TABLE_NAME NOT LIKE '_pg_%'
      AND tc.TABLE_NAME NOT LIKE 'pg_%'
      -- AND tc.TABLE_NAME NOT LIKE 'sql_%'
      -- AND tc.TABLE_NAME NOT LIKE 'routine_%'";
  fi

  local view_sub_query="";
  if [[ "${view_details}" != "none" ]]; then
    local low_detail_prefix="";
    [[ "${view_details}" != "low" ]] && { low_detail_prefix="${sql_comment}"; }
    local high_detail_prefix="";
    [[ "${view_details}" != "high" ]] && { high_detail_prefix="${sql_comment}"; }
    local view_def="${high_detail_prefix}, v.VIEW_DEFINITION AS DATA_TYPE -- use if you want to see the view definitions - chunky";
    view_def+="
    ${low_detail_prefix}, '' AS DATA_TYPE -- use if you want to minify this query - minify";
    local view_sub_query="
UNION
    SELECT
    'view' AS ENTRY_TYPE
    , v.TABLE_NAME
    , '' AS ENTRY_NAME
    ${view_def}
    , '' as IS_NULLABLE
    , 0 as CHARACTER_MAXIMUM_LENGTH
    , 0 as NUMERIC_PRECISION
    , 0 as DATETIME_PRECISION
    , '' as COLUMN_DEFAULT
    FROM INFORMATION_SCHEMA.VIEWS AS v -- WITH(NOLOCK)
    WHERE
      v.TABLE_NAME NOT LIKE '_pg_%'
      AND v.TABLE_NAME NOT LIKE 'pg_%'
      -- AND v.TABLE_NAME NOT LIKE 'sql_%'
      -- AND v.TABLE_NAME NOT LIKE 'routine_%'";
  fi

  local function_sub_query="";
  if [[ "${fn_details}" != "none" ]]; then
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
    FROM INFORMATION_SCHEMA.ROUTINES AS r -- WITH(NOLOCK)
    FULL OUTER JOIN INFORMATION_SCHEMA.PARAMETERS AS p -- WITH(NOLOCK)
      ON p.SPECIFIC_NAME = r.SPECIFIC_NAME
    WHERE
      r.ROUTINE_TYPE IS NOT NULL";
  fi


  local _command="
SELECT
'column' as ENTRY_TYPE
, c.TABLE_NAME
, c.COLUMN_NAME as ENTRY_NAME
, c.DATA_TYPE
, c.IS_NULLABLE
, c.CHARACTER_MAXIMUM_LENGTH
, c.NUMERIC_PRECISION
, c.DATETIME_PRECISION
, c.COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS AS c -- WITH(NOLOCK)
WHERE
  c.TABLE_NAME NOT LIKE '_pg_%'
  AND c.TABLE_NAME NOT LIKE 'pg_%'
  -- AND c.TABLE_NAME NOT LIKE 'sql_%'
  -- AND c.TABLE_NAME NOT LIKE 'routine_%'${constraints_sub_query}${function_sub_query}${view_sub_query}
ORDER BY TABLE_NAME, ENTRY_TYPE, ENTRY_NAME
;
";
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
FROM sys.objects -- WITH(NOLOCK)
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
