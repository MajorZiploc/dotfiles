[CmdletBinding()]
param (
  [Parameter(Mandatory = $false)]
  [ValidateSet("bash", "sql", "all")]
  [string]
  $type = "all"
)

$choices = @{
  'bash' = @{
    'folder' = "~/clipboard/bash/"
    'files' = @{
      'oneline' = @{
        'delimiter'     = "`n"
      }
      'block' = @{
        'delimiter'     = "<:>"
      }
    }
  }
  'sql'  = @{
    'folder' = "~/clipboard/sql/"
    'files' = @{
      'block' = @{
        'delimiter'     = "<:>"
      }
    }
  }
}

function Copy-Snippets {
  [CmdletBinding()]
  param ()
  $choice['files'].Keys | ForEach-Object {
    $snippets_file = $choice['folder'] + $_ + '.txt'
    $delimiter = $choice['files'][$_]['delimiter']
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
