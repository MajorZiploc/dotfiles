@('*.ps1', '*.psd1', '*.psm1') `
| % {
  Get-ChildItem $_ -Recurse | ForEach-Object {
    $content = Get-Content -Path $_
    Set-Content -Path $_.Fullname -Value $content -Encoding UTF8 -PassThru -Force
  }
}
