
cd "~/projects"
ls -Directory `
| % {
  Write-Host $_.Name
  cd $_.Name
  git pull
  cd ..
}

