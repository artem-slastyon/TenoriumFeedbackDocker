#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <git_command_and_args>"
    echo "Example: $0 pull"
    echo "Example: $0 status"
    exit 1
fi

PROJECT_ROOT="$HOME/workspace/feedback/www"
old_pwd=$(pwd);

GIT_COMMAND=("$@")

for repo_folder in "$PROJECT_ROOT"/*; do
  if [ -d "$repo_folder/.git" ]; then
    echo "Entering repository: $(basename $repo_folder)"

    (cd "$repo_folder" && echo "Executing: git " "${GIT_COMMAND[@]}" && git "${GIT_COMMAND[@]}")
  fi
done

echo "Restoring pwd..."

cd "$old_pwd" || exit
