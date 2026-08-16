#!/bin/bash

echo "Building frontend..."

docker-compose -p feedback -f ~/workspace/feedback/docker-compose.yml run -u user php8.4 bash -c "$(cat << EOF
. ~/.nvm/nvm.sh &&
cd /var/www/site &&
npm install
npm run dev
EOF
)"