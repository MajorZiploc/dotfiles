[CmdletBinding()]
param (
    [Parameter(Mandatory=$false)]
    [ValidateSet("bash", "sql", "all")]
    [string]
    $type = "all"
)

$choices = @{
  'bash' = @{
    'snippets_file' = "~/clipboard/snippets_bash.txt"
    'delimiter'= "`n"
  }
  'sql' = @{
    'snippets_file' = "~/clipboard/snippets_sql.txt"
    'delimiter'= "<:>"
  }
}

function Copy-Snippets {
  [CmdletBinding()]
  param ()
  $snippets_file = $choice['snippets_file']
  $delimiter = $choice['delimiter']
  Write-Host "type: $key"
  Write-Host "snippets_file: $snippets_file"
  Write-Host "delimiter: $delimiter"
  [string[]]$snippets = Get-Content -Path $snippets_file -Delimiter $delimiter
  foreach ($snippet in $snippets) {
    Write-Host $snippet
    "$snippet" | clip.exe
    Start-Sleep -Milliseconds 500
  }
}

if ($type -eq "all") {
  $choices.Keys | ForEach-Object {
    $choice = $choices[$_]
    $key = $_
    Copy-Snippets
  }
}
else {
  $choice = $choices[$type]
  $key = $type
  Copy-Snippets
}
