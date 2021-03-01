
$records = Import-Csv -Path "$PSScriptRoot/projs/github_repos_clone.csv"
# Write-Host $records
$root_path="C:\projects"
cd "$root_path"
$records `
| % {
  if (! (Test-Path -Path "$root_path\$($_.repo_name -replace " ", "-")")) {
    # Write-Host "Cloning the Project $($_.repo_name)"
    git clone $_.clone

    # Invoke-Expression -Command $_.clone
  }
  else {
    # Write-Host "Project $($_.repo_name) already exists! Not cloning this repo."
  }
}

