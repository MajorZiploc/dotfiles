
cd "~/projects"
ls -Directory | ForEach-Object {
  Write-Host $_.Name
  cd $_.Name
  git pull
  cd ..
}

