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
begin {
  $msg = "Started process"
  Write-EventLog -LogName 'clipboard' -Source 'copy' -EntryType Information -EventId 1 -Message $msg
}

process {
try {
  Copy-Snippets -ErrorAction Stop
  $msg = "Successful copy"
  Write-EventLog -LogName 'clipboard' -Source 'copy' -EntryType SuccessAudit -EventId 1 -Message $msg
}
catch {
  $msg = $_.ToString()
  Write-EventLog -LogName 'clipboard' -Source 'copy' -EntryType FailureAudit -EventId 1 -Message $msg
}
}

end {
  $msg = "Finished process"
  Write-EventLog -LogName 'clipboard' -Source 'copy' -EntryType Information -EventId 1 -Message $msg
}
}

Program
