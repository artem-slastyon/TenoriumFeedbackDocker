#!/bin/bash

echo "Starting build of docker containers..."

docker-compose -p feedback -f ~/workspace/feedback/docker-compose.yml build