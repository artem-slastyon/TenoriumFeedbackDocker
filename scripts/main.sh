#!/bin/bash

general_help() {
  help=$(cat << 'EOF'
  Tenorium Feedback

  Usage: feedback <command> [options]

  \e[0;36mGeneral\e[0m commands:
  \e[1;32mdocker\e[0m - Docker commands
  \e[1;32msetup\e[0m - Setup/Update environment\n
  \e[1;32mmkcert\e[0m - Run mkcert command

  \e[0;36mVite\e[0m commands:
  \e[1;32mbuild\e[0m - Build project
  \e[1;32mwatch\e[0m - Watch project

  \e[0;36mPHP\e[0m commands:
  \e[1;32martisan\e[0m - Execute artisan command
  \e[1;32mcomposer\e[0m - Execute composer command

  \e[0;36mGit\e[0m commands:
  \e[1;32mclone\e[0m - Clone repositories that not cloned yet
  \e[1;32mgit\e[0m - Run git command for each repository


  \e[0;36mPower\e[0m commands:
  \e[1;32mup\e[0m - Start containers
  \e[1;32mdown\e[0m - Stop containers
  \e[1;32mrestart\e[0m - Restart containers
EOF
  )

  echo -e "$help"
}

docker_help() {
  help=$(cat << 'EOF'
  Feedback Docker Commands

  Usage: feedback docker <command>

  Commands:
  \e[1;32mbuild\e[0m - Build docker containers
  \e[1;32mexec\e[0m - Exec bash command in selected service
  \e[1;32mtemp\e[0m - Run temporary ubuntu:22.04 container
  \e[1;32mwatch\e[0m - Watch build context
EOF
  )

  echo -e "$help"
}

docker_handle() {
  if [ $# -eq 0 ]; then
    docker_help
    exit 0
  elif [ -z "$1" ]; then
    docker_help
    exit 0
  fi

  command=$1
  args=("${@:2}")

  DOCKER_FUNCTIONS="$FUNCTIONS_DIR/docker"

  DOCKER_BUILD_SCRIPT_PATH="$DOCKER_FUNCTIONS/build.sh"
  EXEC_SCRIPT_PATH="$DOCKER_FUNCTIONS/exec.sh"
  TEMP_SCRIPT_PATH="$DOCKER_FUNCTIONS/temp.sh"
  WATCH_SCRIPT_PATH="$DOCKER_FUNCTIONS/watch.sh"

  case "$command" in
  "build")
  $DOCKER_BUILD_SCRIPT_PATH "${args[@]}";;
  "exec")
  $EXEC_SCRIPT_PATH "${args[@]}";;
  "temp")
  $TEMP_SCRIPT_PATH "${args[@]}";;
  "watch")
  $WATCH_SCRIPT_PATH "${args[@]}";;
  *)
  docker_help
  exit
  ;;
  esac
}

if [[ $# -eq 0 ]]; then
  general_help
  exit 0
fi

command=$1
args=("${@:2}")
FUNCTIONS_DIR="$( dirname -- "$0";)/functions"

ARTISAN_SCRIPT_PATH="$FUNCTIONS_DIR/php/artisan.sh"
BUILD_SCRIPT_PATH="$FUNCTIONS_DIR/build.sh"
COMPOSER_SCRIPT_PATH="$FUNCTIONS_DIR/php/composer.sh"
POWER_ACTION_SCRIPT_PATH="$FUNCTIONS_DIR/power-action.sh"
SETUP_SCRIPT_PATH="$FUNCTIONS_DIR/setup.sh"
CLONE_SCRIPT_PATH="$FUNCTIONS_DIR/clone.sh"
GIT_SCRIPT_PATH="$FUNCTIONS_DIR/git.sh"
WATCH_SCRIPT_PATH="$FUNCTIONS_DIR/watch.sh"
MKCERT_SCRIPT_PATH="$FUNCTIONS_DIR/mkcert.sh"

case "$command" in
"artisan")
$ARTISAN_SCRIPT_PATH "${args[@]}";;
"build")
$BUILD_SCRIPT_PATH "${args[@]}";;
"composer")
$COMPOSER_SCRIPT_PATH "${args[@]}";;
"docker")
docker_handle "${args[@]}";;
"mkcert")
$MKCERT_SCRIPT_PATH "${args[@]}";;
"up")
$POWER_ACTION_SCRIPT_PATH "up" "${args[@]}";;
"down")
$POWER_ACTION_SCRIPT_PATH "down" "${args[@]}";;
"restart")
$POWER_ACTION_SCRIPT_PATH "restart" "${args[@]}";;
"setup")
$SETUP_SCRIPT_PATH;;
"clone")
$CLONE_SCRIPT_PATH;;
"git")
$GIT_SCRIPT_PATH "${args[@]}";;
"watch")
$WATCH_SCRIPT_PATH "${args[@]}";;
*)
  general_help
  exit 0
;;

esac
