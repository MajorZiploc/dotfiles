function Program {
  [CmdletBinding()]
  param ()
  [string[]]$snippets = Get-Content -Path "~/clipboard/snippets.txt"
  foreach ($snippet in $snippets) {
    Write-Host $snippet
    "$snippet" | clip.exe
    Start-Sleep -Milliseconds 500
  }
}

try {
  $msg = "Starting copying"
  Write-EventLog -LogName 'clipboard' -Source 'copy' -EntryType Information -EventId 1 -Message $msg
  Program -ErrorAction Stop
  $msg = "Finished running"
  Write-EventLog -LogName 'clipboard' -Source 'copy' -EntryType SuccessAudit -EventId 1 -Message $msg
}
catch {
  $msg = $_.ToString()
  Write-EventLog -LogName 'clipboard' -Source 'copy' -EntryType FailureAudit -EventId 1 -Message $msg
}

