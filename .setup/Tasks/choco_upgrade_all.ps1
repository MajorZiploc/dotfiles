function Upgrade-Choco {
  cup all -y --except="python3"
}

function Program {
  param ()
begin {
  $msg = "Started process"
  Write-EventLog -LogName 'choco' -Source 'upgrade' -EntryType Information -EventId 1 -Message $msg
}

process {
try {
  Upgrade-Choco -ErrorAction SilentlyContinue -ErrorVariable ProcessError
  if ($ProcessError) {
    $msg = "Something went wrong. $ProcessError"
    Write-EventLog -LogName 'choco' -Source 'upgrade' -EntryType FailureAudit -EventId 1 -Message $msg
  } else {
    $msg = "Successful upgrade"
    Write-EventLog -LogName 'choco' -Source 'upgrade' -EntryType SuccessAudit -EventId 1 -Message $msg
  }
}
catch {
  $msg = $_.ToString()
  Write-EventLog -LogName 'choco' -Source 'upgrade' -EntryType FailureAudit -EventId 1 -Message $msg
}
}

end {
  $msg = "Finished process"
  Write-EventLog -LogName 'choco' -Source 'upgrade' -EntryType Information -EventId 1 -Message $msg
}
}

Program
