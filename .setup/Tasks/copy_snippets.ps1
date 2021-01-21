
[string[]]$snippets = Get-Content -Path "~/clipboard/snippets.txt"
foreach ($snippet in $snippets) {
  echo $snippet
  "$snippet" | clip.exe
  Start-Sleep -Milliseconds 500
}