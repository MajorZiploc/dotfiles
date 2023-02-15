function aws_ecs_tasks_describe {
  local cluster_name="$1";
  [[ -z "$cluster_name"]] && { echo "Must specify cluster_name\!" >&2; return 1; }
  aws ecs describe-tasks --task `aws ecs list-tasks --cluster "$cluster_name" | egrep -i "arn:" | tr -d "," | xargs` --cluster "$cluster_name";
}

function aws_ecs_container_connect {
  local cluster_name="$1";
  [[ -z "$cluster_name"]] && { echo "Must specify cluster_name\!" >&2; return 1; }
  local task_id="$2";
  [[ -z "$task_id"]] && { echo "Must specify task_id\!" >&2; return 1; }
  local container_name="$3";
  [[ -z "$container_name"]] && { echo "Must specify container_name\!" >&2; return 1; }
  local command="$4";
  command="${command:="/bin/sh"}";
  aws ecs execute-command --cluster "$cluster_name" --task "$task_id" --container "$container_name" --interactive --command "$command";
}

function aws_whoami {
  aws sts get-caller-identity;
}

function aws_ecr_repo_create {
  local repository_name="$1";
  [[ -z "$repository_name"]] && { echo "Must specify repository_name\!" >&2; return 1; }
  aws ecr create-repository --no-paginate --repository-name "$repository_name";
}

function aws_ecr_repo_delete {
  local repository_name="$1";
  [[ -z "$repository_name"]] && { echo "Must specify repository_name\!" >&2; return 1; }
  aws ecr delete-repository --no-paginate --repository-name "$repository_name";
}

