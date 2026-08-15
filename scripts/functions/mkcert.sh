#!/bin/bash

CERTS_ROOT="$HOME/workspace/feedback/certs"
old_pwd=$(pwd)
MKCERT_COMMAND=("$@")

echo "Entering certs folder"
cd "$CERTS_ROOT" && echo "Executing: mkcert " "${MKCERT_COMMAND[@]}" && mkcert "${MKCERT_COMMAND[@]}"

echo "Restoring pwd..."
cd "$old_pwd" || exit