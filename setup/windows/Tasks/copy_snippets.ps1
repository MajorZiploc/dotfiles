[CmdletBinding()]
param (
    [Parameter(Mandatory=$false)]
    [string]
    $type = "bash"
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

$choice = $choices[$type]

function Copy-Snippets {
  [CmdletBinding()]
  param ()
  $snippets_file = $choice['snippets_file']
  $delimiter = $choice['delimiter']
  [string[]]$snippets = Get-Content -Path $snippets_file -Delimiter $delimiter
  foreach ($snippet in $snippets) {
    Write-Host $snippet
    "$snippet" | clip.exe
    Start-Sleep -Milliseconds 500
  }
}

Copy-Snippets
