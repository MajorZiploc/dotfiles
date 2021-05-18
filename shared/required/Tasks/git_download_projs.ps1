
# $records = Import-Csv -Path "$PSScriptRoot/projs/bitbucket_clone.csv"
$records = Import-Csv -Path "$PSScriptRoot/projs/github_repos_clone.csv"
# Write-Host $records
$root_path="~/projects"
cd "$root_path"
$records `
| % {
  if (! (Test-Path -Path "$root_path\$($_.repo_name -replace " ", "-")")) {
    # Write-Host "Cloning the Project $($_.repo_name)"
    # bitbucket
    # Invoke-Expression -Command $_.clone

    # github
    git clone $_.clone
  }
  else {
    # Write-Host "Project $($_.repo_name) already exists! Not cloning this repo."
  }
}

