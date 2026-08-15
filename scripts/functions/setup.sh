#!/bin/bash

echo "Updating/Inserting alias..."

if [ -f "$HOME/.bashrc" ]; then
    sed -i '/#Feedback/d' ~/.bashrc
    echo "source \$HOME/workspace/feedback/scripts/main_completion.sh #Feedback" >> ~/.bashrc
fi
    
if [ -f "$HOME/.zshrc" ]; then
    sed -i '/#Feedback/d' ~/.zshrc
    echo "source \$HOME/workspace/feedback/scripts/main_completion.sh #Feedback" >> ~/.zshrc
fi

echo "Updating /etc/hosts... (need privileged access)"
sudo sed -i '/#Feedback/d' /etc/hosts
echo "127.0.0.1 feedback.tenorium.local #Feedback" | sudo tee -a /etc/hosts >> /dev/null

FUNCTIONS_PATH="$( dirname -- "$0";)"
MAIN_SCRIPT_PATH="$( dirname -- "$FUNCTIONS_PATH";)/main.sh"

$MAIN_SCRIPT_PATH clone
$MAIN_SCRIPT_PATH mkcert feedback.tenorium.local
$MAIN_SCRIPT_PATH up
cp ~/workspace/feedback/www/site/.env.docker ~/workspace/feedback/www/site/.env

echo "Waiting for MySQL..."
until docker-compose exec -T db mariadb-admin ping -h "localhost" --silent; do
    echo -n "."
    sleep 1
done
echo "Database ready"

$MAIN_SCRIPT_PATH composer install -o --no-interaction
$MAIN_SCRIPT_PATH artisan migrate --seed --no-interaction
$MAIN_SCRIPT_PATH build
