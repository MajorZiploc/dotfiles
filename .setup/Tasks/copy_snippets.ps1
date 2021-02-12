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
  $msg = "Started process"
  Copy-Snippets -ErrorAction Stop
  $msg = "Successful copy"
}
catch {
  $msg = $_.ToString()
}
}

end {
  $msg = "Finished process"
}
}

Program
