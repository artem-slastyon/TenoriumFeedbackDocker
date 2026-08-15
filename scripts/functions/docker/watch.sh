#!/bin/bash

docker-compose -p feedback -f ~/workspace/feedback/docker-compose.yml watch "$@"