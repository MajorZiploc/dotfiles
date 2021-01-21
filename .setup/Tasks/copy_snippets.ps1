$logName = 'clipboard'
$logSource = 'copy'

function Copy-Snippets {
  [CmdletBinding()]
  param ()
  [string[]]$snippets = Get-Content -Path "~/clipboard/snippets.txt"
  foreach ($snippet in $snippets) {
    Write-Host $snippet
    "$snippet" | clip.exe
    Start-Sleep -Milliseconds 500
  }
}

function Program {
  param ()

process {
try {
  # Event log checks and initialization
  # Ref: http://msdn.microsoft.com/en-us/library/system.diagnostics.eventlog.exists(v=vs.110).aspx
  # Check if Log exists
  $doesAppExist = [System.Diagnostics.EventLog]::Exists($logName);
  # Ref: http://msdn.microsoft.com/en-us/library/system.diagnostics.eventlog.sourceexists(v=vs.110).aspx
  # Check if Source exists
  $doesSourceExist = [System.Diagnostics.EventLog]::SourceExists($logSource);
  if ( !$doesAppExist -or !$doesSourceExist ) {
    New-EventLog -LogName $logName -Source $logSource
  }

  $msg = "Started process"
  Write-EventLog -LogName $logName -Source $logSource -EntryType Information -EventId 1 -Message $msg
  Copy-Snippets -ErrorAction Stop
  $msg = "Successful copy"
  Write-EventLog -LogName $logName -Source $logSource -EntryType SuccessAudit -EventId 1 -Message $msg
}
catch {
  $msg = $_.ToString()
  Write-EventLog -LogName $logName -Source $logSource -EntryType FailureAudit -EventId 1 -Message $msg
}
}

end {
  $msg = "Finished process"
  Write-EventLog -LogName $logName -Source $logSource -EntryType Information -EventId 1 -Message $msg
}
}

Program
