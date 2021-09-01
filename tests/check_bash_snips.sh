#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

@test "check snip_bash_for_loop" {
  function f(){
    snip_bash_for_loop;
  }
  expected=`echo '
IFS= ;
l=(1 2 3 "4");
for ele in \${l[@]};
  do echo "\$ele" hi;
done;
unset IFS;

'
`
  expected=`echo "$expected" | tr -d '\'`
  run f
  assert_success
  assert_output "$expected"
}

@test "check snip_sql_search_column" {
  function f(){
    snip_sql_search_column;
  }
  expected=`cat << EOF
/* SQL column search */
SELECT
c.name  AS 'ColumnName'
,t.name AS 'TableName'
,TYPE_NAME(c.user_type_id) AS 'ColumnType'
,c.max_length AS 'ColumnTypeLength'
,c.is_nullable AS 'ColumnIsNullable'
FROM sys.columns c WITH(NOLOCK)
JOIN sys.tables  t WITH(NOLOCK)
  ON c.object_id = t.object_id
WHERE c.name LIKE '%ColumnPattern%'
ORDER BY TableName, ColumnName
;
EOF
`
  expected=`echo "$expected" | tr -d '\'`
  run f
  assert_success
  assert_output "$expected"
}

@test "check snip_sql_search_general" {
  function f(){
    snip_sql_search_general;
  }
  expected=`cat << EOF
/* SQL general search, NOT FOR COLUMNS */
SELECT
name AS [Name],
SCHEMA_NAME(schema_id) AS schema_name,
type_desc,
create_date,
modify_date
FROM sys.objects WITH(NOLOCK)
WHERE name LIKE '%Pattern%'
AND type ='u'
;
EOF
`
  expected=`echo "$expected" | tr -d '\'`
  run f
  assert_success
  assert_output "$expected"
}

@test "check snip_sql_show_table_info" {
  function f(){
    snip_sql_show_table_info;
  }
  expected=`cat << EOF
/* SQL get table information */
SELECT c.TABLE_NAME
, c.COLUMN_NAME
, c.IS_NULLABLE
, c.DATA_TYPE
, c.CHARACTER_MAXIMUM_LENGTH
, c.NUMERIC_PRECISION
, c.DATETIME_PRECISION
, c.COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS AS c WITH(NOLOCK)
-- WHERE c.TABLE_NAME LIKE '%table_name%'
ORDER BY c.TABLE_NAME
;
EOF
`
  expected=`echo "$expected" | tr -d '\'`
  run f
  assert_success
  assert_output "$expected"
}

@test "check snip_sql_show_function_info" {
  function f(){
    snip_sql_show_function_info;
  }
  expected=`cat << EOF
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
FROM INFORMATION_SCHEMA.ROUTINES AS r WITH(NOLOCK)
FULL OUTER JOIN INFORMATION_SCHEMA.PARAMETERS AS p WITH(NOLOCK)
  ON p.SPECIFIC_NAME = r.SPECIFIC_NAME
-- WHERE r.SPECIFIC_NAME LIKE '%function_name%'
ORDER BY r.SPECIFIC_NAME, p.PARAMETER_NAME, p.DATA_TYPE
;
EOF
`
  expected=`echo "$expected" | tr -d '\'`
  run f
  assert_success
  assert_output "$expected"
}

@test "check snip_sql_show_table_constraints" {
  function f(){
    snip_sql_show_table_constraints;
  }
  expected=`cat << EOF
/* SQL get table constraints information */
SELECT tc.TABLE_NAME
, tc.CONSTRAINT_NAME
, tc.CONSTRAINT_TYPE
, tc.TABLE_CATALOG
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc WITH(NOLOCK)
-- WHERE tc.TABLE_NAME LIKE '%table_name%'
ORDER BY tc.TABLE_NAME, tc.CONSTRAINT_NAME
;
EOF
`
  expected=`echo "$expected" | tr -d '\'`
  run f
  assert_success
  assert_output "$expected"
}

@test "check snip_pwsh_init_module" {
  function f(){
    snip_pwsh_init_module;
  }
  expected=`cat << EOF
pwsh -Command '& {Set-StrictMode -Version 3; Import-Module powershell_scaffolder; Initialize-Module -Path ./ -ModuleName \"test\" -Author \"Manyu Lakhotia\" -Description \"Test powershell module\" -ModuleVersion \"0.0.1\" -PowershellVersion \"5.1\" -CompanyName \"N/A\" -CopyRight \"N/A\";}'
EOF
`
  expected=`echo "$expected" | tr -d '\'`
  run f
  assert_success
  assert_output "$expected"
}

@test "check snip_pwsh_init_script" {
  function f(){
    snip_pwsh_init_script;
  }
  expected=`cat << EOF
pwsh -Command '& {Set-StrictMode -Version 3; Import-Module powershell_scaffolder; Initialize-Script -Path ./ -ScriptName "test" -ShouldUseAdvLogging \$false}'
EOF
`
  expected=`echo "$expected" | tr -d '\'`
  run f
  assert_success
  assert_output "$expected"
}

