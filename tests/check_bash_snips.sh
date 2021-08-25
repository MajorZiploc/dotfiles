#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

@test "check snip_bash_for_loop" {
  function f(){
    snip_bash_for_loop;
  }
  expected=`cat << EOF
IFS= ;
l=(1 2 3 "4");
for ele in \${l[@]};
  do echo "\$ele" hi;
done;
unset IFS;
EOF
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
FROM sys.columns c
JOIN sys.tables  t ON c.object_id = t.object_id
WHERE c.name LIKE '%ColumnPattern%'
ORDER BY TableName, ColumnName;
EOF
`
  expected=`echo "$expected" | tr -d '\'`
  run f
  assert_success
  assert_output "$expected"
}

@test "check snip_sql_general_search" {
  function f(){
    snip_sql_general_search;
  }
  expected=`cat << EOF
/* SQL general search, NOT FOR COLUMNS */
SELECT
name AS [Name], 
SCHEMA_NAME(schema_id) AS schema_name, 
type_desc, 
create_date, 
modify_date
FROM sys.objects
WHERE name LIKE '%Pattern%'
AND type ='u';
EOF
`
  expected=`echo "$expected" | tr -d '\'`
  run f
  assert_success
  assert_output "$expected"
}

@test "check snip_sql_table_info" {
  function f(){
    snip_sql_table_info;
  }
  expected=`cat << EOF
/* SQL get table information */
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='table_name'
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

