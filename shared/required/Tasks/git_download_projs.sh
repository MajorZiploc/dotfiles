# projects_path="./projs/bitbucket_clone.csv";
projects_path="./projs/github_repos_clone.csv";
projects_path_dirty="$HOME/Downloads/github_repos_clone.csv";
origin_style="github";

# Optional: cleaning step
cat "$projects_path_dirty" | rbql --with-header --query "Select distinct a.clone where '${origin_style}' in a.clone" --delim ',' --policy quoted_rfc > "${projects_path}";

projects=$(rbql --with-header --query "Select distinct a.clone" --delim ',' --policy quoted_rfc --input "$projects_path" | tail -n +2);
root_path="$HOME/projects";
cd "$root_path";

for project in ${projects}; do
  # echo "$project" hi;

  # bitbucket
  # eval "$project";

  # github
  git clone "$project";
done;

