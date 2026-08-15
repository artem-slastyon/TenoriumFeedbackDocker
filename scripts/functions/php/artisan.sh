#!/bin/bash

docker-compose -p feedback -f ~/workspace/feedback/docker-compose.yml run --rm -u user php8.4 php artisan "$@"