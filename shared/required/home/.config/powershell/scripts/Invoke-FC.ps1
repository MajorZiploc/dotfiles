function Invoke-FC {
  param (
    [string]$Editor = "nvim"
  )
  $startExecutionTime = [datetime]::Now
  $lastCommand = (Get-History | Select-Object -Last 1).CommandLine
  if (-not $lastCommand) {
    Write-Host "No commands in history."
    return
  }
  $tempFile = [System.IO.Path]::GetTempFileName()
  Set-Content -Path $tempFile -Value $lastCommand
  Start-Process -NoNewWindow -Wait $Editor $tempFile
  $editedCommand = Get-Content -Path $tempFile -Raw
  Remove-Item $tempFile
  if ($editedCommand) {
    try {
      Invoke-Expression $editedCommand
    } finally {
      # Add the edited command to the history
      $newEntry = [pscustomobject]@{
        CommandLine        = "$editedCommand"
        ExecutionStatus    = "Completed"
        StartExecutionTime =  $startExecutionTime
        EndExecutionTime   = [datetime]::Now
      }
      $commands = @()
      $commands += $newEntry
      Add-History -InputObject $commands -PassThru
      # this adds to the up arrow in interactive
      [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($editedCommand)
    }
  }
}

# NOTE: is fc in unix. dc is file compare in windows tho. so using gv instead
Set-Alias dc Invoke-FC
