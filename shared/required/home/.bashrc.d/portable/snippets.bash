function snip_sql_column_view_fn_info {
  # choices: ["none", "low", "high"]
  local sql_flavor="$1"; sql_flavor="${sql_flavor:-"pgsql"}";
  local constraint_details="$2"; constraint_details="${constraint_details:-"low"}";
  local view_details="$3"; view_details="${view_details:-"low"}";
  local fn_details="$4"; fn_details="${fn_details:-"low"}";
  local trigger_details="$5"; trigger_details="${trigger_details:-"low"}";
  if [[ "${sql_flavor}" == "sqlite" ]]; then
    echo "SELECT name, '\"' || sql || '\"' as sql
FROM sqlite_master
WHERE type = 'table'
AND name NOT LIKE 'sqlite_%';";
    return 0;
  fi
  local table_access_modifier="";
  [[ "${sql_flavor}" == "mssql" ]] && { table_access_modifier=" WITH(NOLOCK)"; }
  local sql_comment="-- ";
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
    local indexes_sub_query="";
    if [[ "${sql_flavor}" == "mssql" ]]; then
    local indexes_sub_query="
UNION
    SELECT 
    'index' as ENTRY_TYPE
    , i.name AS TABLE_NAME -- IndexName
    , c.name AS ENTRY_NAME -- ColumnName
    , cast(i.type_desc as varchar) COLLATE SQL_Latin1_General_CP1_CI_AS AS DATA_TYPE -- IndexType
    , '' as IS_NULLABLE
    , 0 as CHARACTER_MAXIMUM_LENGTH
    , 0 as NUMERIC_PRECISION
    , 0 as DATETIME_PRECISION
    , concat('i.is_unique:', cast(i.is_unique as varchar), ' ', 'i.is_primary_key:', cast(i.is_primary_key as varchar), ' ', 'ic.key_ordinal:', cast(ic.key_ordinal as varchar)) as COLUMN_DEFAULT
    FROM sys.indexes as i${table_access_modifier}
    INNER JOIN sys.index_columns as ic${table_access_modifier} ON i.object_id = ic.object_id AND i.index_id = ic.index_id
    INNER JOIN sys.columns as c${table_access_modifier} ON ic.object_id = c.object_id AND ic.column_id = c.column_id
    -- WHERE 
    --     i.object_id = OBJECT_ID('SchemaName.TableName')";
    fi
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
      $table_name_filter"}";
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
      --lower(r.ROUTINE_TYPE) AS ENTRY_TYPE
      'function' AS ENTRY_TYPE
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

  local trigger_sub_query="";
  if [[ "${trigger_details}" != "none" ]]; then
    if [[ "${sql_flavor}" == "mysql" || "${sql_flavor}" == "mariadb" ]]; then
      echo "-- WARNING: ${sql_flavor} does not support trigger sub query! Will not be included in resulting query. TODO: look into adding this";
    else
      if [[ "${sql_flavor}" == "pgsql" ]]; then
        local low_detail_prefix="";
        [[ "${trigger_details}" != "low" ]] && { low_detail_prefix="${sql_comment}"; }
        local high_detail_prefix="";
        [[ "${trigger_details}" != "high" ]] && { high_detail_prefix="${sql_comment}"; }
        trigger_def="${high_detail_prefix}, trg.tgfoid::regprocedure::text AS COLUMN_DEFAULT -- AS FUNCTION_NAME -- use if you want to see the trigger definitions - chunky";
        trigger_def+="
        ${low_detail_prefix}, '' AS COLUMN_DEFAULT -- use if you want to minify this query - minify";
      trigger_sub_query="
  UNION
      SELECT 
      'trigger' AS ENTRY_TYPE
      , trg.tgrelid::regclass::text AS TABLE_NAME
      , trg.tgname AS ENTRY_NAME
      , trg.tgtype::text AS DATA_TYPE
      , CASE
          WHEN trg.tgenabled = 'O' THEN 'ENABLED'
          ELSE 'DISABLED'
        END AS IS_NULLABLE -- AS TRIGGER_ENABLED,
      , 0 AS CHARACTER_MAXIMUM_LENGTH
      , 0 AS NUMERIC_PRECISION
      , 0 AS DATETIME_PRECISION
      ${trigger_def}
      FROM pg_trigger as trg ${table_access_modifier}
      WHERE
          trg.tgisinternal = FALSE";
      elif [[ "${sql_flavor}" == "mssql" ]]; then
        local low_detail_prefix="";
        [[ "${trigger_details}" != "low" ]] && { low_detail_prefix="${sql_comment}"; }
        local high_detail_prefix="";
        [[ "${trigger_details}" != "high" ]] && { high_detail_prefix="${sql_comment}"; }
        trigger_def="${high_detail_prefix}, m.definition AS COLUMN_DEFAULT -- AS FUNCTION_NAME -- use if you want to see the trigger definitions - chunky";
        trigger_def+="
        ${low_detail_prefix}, '' AS COLUMN_DEFAULT -- use if you want to minify this query - minify";
      trigger_sub_query="
  UNION
      SELECT
      'trigger' AS ENTRY_TYPE
      , o.name AS TABLE_NAME
      , t.name AS ENTRY_NAME
      , CONCAT('is_instead_of_trigger:', t.is_instead_of_trigger) AS DATA_TYPE
      , CASE
          WHEN t.is_disabled = 0 THEN 'ENABLED'
          ELSE 'DISABLED'
        END AS IS_NULLABLE -- AS TRIGGER_ENABLED,
      , 0 AS CHARACTER_MAXIMUM_LENGTH
      , 0 AS NUMERIC_PRECISION
      , 0 AS DATETIME_PRECISION
      ${trigger_def}
      FROM sys.triggers AS t ${table_access_modifier}
      JOIN sys.objects AS o ${table_access_modifier} ON t.parent_id = o.object_id
      JOIN sys.sql_modules AS m ${table_access_modifier} ON t.object_id = m.object_id
      WHERE
          o.type = 'U';  -- Only user tables";
      fi
    fi
  fi

  local rest=${constraints_sub_query}${indexes_sub_query}${function_sub_query}${view_sub_query}${trigger_sub_query};
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
WHERE $table_name_filter"}${rest} ";
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
