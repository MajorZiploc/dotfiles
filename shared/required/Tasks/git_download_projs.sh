# projects_path="./projs/bitbucket_clone.csv";
projects_path="./projs/github_repos_clone.csv";
projects=($(rbql --with-header --query "Select distinct a.clone" --delim ',' --policy quoted_rfc --input "$projects_path" | tail -n +2));
$root_path="~/projects"
cd "$root_path"

for project in ${projects[@]}; do
  # echo "$project" hi;

  # bitbucket
  # eval "$_.clone";

  # github
  git clone $_.clone;
done;

