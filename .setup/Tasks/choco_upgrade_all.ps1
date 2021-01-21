$logName = 'choco'
$logSource = 'upgrade'
function Upgrade-Choco {
  cup all -y --except="python3"
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
  Upgrade-Choco -ErrorAction SilentlyContinue -ErrorVariable ProcessError
  if ($ProcessError) {
    $msg = "Something went wrong. $ProcessError"
    Write-EventLog -LogName $logName -Source $logSource -EntryType FailureAudit -EventId 1 -Message $msg
  } else {
    $msg = "Successful upgrade"
    Write-EventLog -LogName $logName -Source $logSource -EntryType SuccessAudit -EventId 1 -Message $msg
  }
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
