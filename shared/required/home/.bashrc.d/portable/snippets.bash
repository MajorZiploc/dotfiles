function snip_bash_for_loop {
echo '
IFS=$'"'\\\\n'"';
l=(1 2 3 "4");
for ele in ${l[@]}; do
  echo "$ele" hi;
done;
unset IFS;
';
}

function snip_bash_while {
echo '
echo "$eles" | while read -d $'"'\\\\n'"' ele; do
  echo "$ele hi";
done;
';
}

function snip_bash_while_stream {
echo '
while read -d $'"'\\\\n'"' ele; do
  echo "$ele hi";
done < <(echo "$eles");
';
}

function snip_sql_search_column {
  local snip=`cat << EOF
/* SQL column search */
SELECT
c.name  AS 'ColumnName'
,t.name AS 'TableName'
,TYPE_NAME(c.user_type_id) AS 'ColumnType'
,c.max_length AS 'ColumnTypeLength'
,c.is_nullable AS 'ColumnIsNullable'
FROM sys.columns c -- WITH(NOLOCK)
JOIN sys.tables  t -- WITH(NOLOCK)
  ON c.object_id = t.object_id
WHERE c.name LIKE '%ColumnPattern%'
ORDER BY TableName, ColumnName
;
EOF
`;
  echo "$snip";
}

function snip_sql_search_general {
  local snip=`cat << EOF
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

function snip_sql_column_info {
  local snip=`cat << EOF
/* SQL get column information */
SELECT
c.TABLE_CATALOG
, c.TABLE_NAME
, c.COLUMN_NAME
, c.IS_NULLABLE
, c.DATA_TYPE
, c.CHARACTER_MAXIMUM_LENGTH
, c.NUMERIC_PRECISION
, c.DATETIME_PRECISION
, c.COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS AS c -- WITH(NOLOCK)
-- WHERE c.TABLE_NAME LIKE '%table_name%'
ORDER BY c.TABLE_NAME
;
EOF
`;
  echo "$snip";
}

function snip_sql_function_info {
  local snip=`cat << EOF
/* SQL get function information */
/* Includes functions, sprocs, and those with/without params */
SELECT
r.SPECIFIC_NAME
, r.ROUTINE_TYPE
, p.PARAMETER_NAME
, p.DATA_TYPE
, p.CHARACTER_MAXIMUM_LENGTH
, r.ROUTINE_CATALOG
, r.SQL_DATA_ACCESS
, r.CREATED
, r.LAST_ALTERED
, r.ROUTINE_DEFINITION
FROM INFORMATION_SCHEMA.ROUTINES AS r -- WITH(NOLOCK)
FULL OUTER JOIN INFORMATION_SCHEMA.PARAMETERS AS p -- WITH(NOLOCK)
  ON p.SPECIFIC_NAME = r.SPECIFIC_NAME
-- WHERE r.SPECIFIC_NAME LIKE '%function_name%'
ORDER BY r.SPECIFIC_NAME, p.PARAMETER_NAME, p.DATA_TYPE
;
EOF
`;
  echo "$snip";
}

function snip_sql_table_constraints {
  local snip=`cat << EOF
/* SQL get table constraints information */
SELECT tc.TABLE_NAME
, tc.CONSTRAINT_NAME
, tc.CONSTRAINT_TYPE
, tc.TABLE_CATALOG
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc -- WITH(NOLOCK)
-- WHERE tc.TABLE_NAME LIKE '%table_name%'
ORDER BY tc.TABLE_NAME, tc.CONSTRAINT_NAME
;
EOF
`;
  echo "$snip";
}

function snip_sql_table_and_view_info {
  local snip=`cat << EOF
/* SQL get table and view information */
SELECT
t.TABLE_CATALOG
, t.TABLE_NAME
, NULL AS VIEW_DEFINITION
FROM INFORMATION_SCHEMA.TABLES AS t -- WITH(NOLOCK)
-- WHERE t.TABLE_NAME LIKE '%table_name%'
UNION
SELECT
v.TABLE_CATALOG
, v.TABLE_NAME
, v.VIEW_DEFINITION
FROM INFORMATION_SCHEMA.VIEWS AS v -- WITH(NOLOCK)
-- WHERE v.TABLE_NAME LIKE '%table_name%'
ORDER BY TABLE_NAME
;
EOF
`;
  echo "$snip";
}

function snip_pwsh_init_module {
  local snip=`cat << EOF
pwsh -Command '& {Set-StrictMode -Version 3; Import-Module powershell_scaffolder; Initialize-Module -Path ./ -ModuleName "test" -Author "Manyu Lakhotia" -Description "Test powershell module" -ModuleVersion "0.0.1" -PowershellVersion "5.1" -CompanyName "N/A" -CopyRight "N/A";}'
EOF
`;
  echo "$snip";
}

function snip_pwsh_init_script {
  local snip=`cat << EOF
pwsh -Command '& {Set-StrictMode -Version 3; Import-Module powershell_scaffolder; Initialize-Script -Path ./ -ScriptName "test" -ShouldUseAdvLogging $false}'
EOF
`;
  echo "$snip";
}

