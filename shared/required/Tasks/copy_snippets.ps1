[CmdletBinding()]
param (
    [Parameter(Mandatory=$false)]
    [ValidateSet("bash_oneline", "sql_block", "all")]
    [string]
    $type = "all"
)

$choices = @{
  'bash_oneline' = @{
    'snippets_file' = "~/clipboard/bash/oneline.txt"
    'delimiter'= "`n"
  }
  'sql_block' = @{
    'snippets_file' = "~/clipboard/sql/block.txt"
    'delimiter'= "<:>"
  }
}

function Copy-Snippets {
  [CmdletBinding()]
  param ()
  $snippets_file = $choice['snippets_file']
  $delimiter = $choice['delimiter']
  Write-Host "`n"
  Write-Host "------------------------"
  Write-Host "type: $key"
  Write-Host "snippets_file: $snippets_file"
  Write-Host "delimiter: $delimiter"
  Write-Host "------------------------"
  [string[]]$snippets = Get-Content -Path $snippets_file -Delimiter $delimiter
  foreach ($snippet in $snippets) {
    if (![string]::IsNullOrWhiteSpace("$snippet")) {
      Write-Host "$snippet"
      "$snippet" | clip.exe
      Start-Sleep -Milliseconds 500
    }
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
