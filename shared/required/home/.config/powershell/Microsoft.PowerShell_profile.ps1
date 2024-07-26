ls "$HOME/.config/powershell/scripts" | % { . $_.FullName }

function Invoke-Which {
  param (
    [string]$command
  )
  Get-Command "$command" | Select-Object -ExpandProperty Definition
}

New-Alias which Invoke-Which
