#!/bin/bash

service=$1
args=("${@:2}")

echo "Executing command... in $service"

docker-compose -p feedback -f ~/workspace/feedback/docker-compose.yml exec -u user -it "$service" bash "${args[@]}"