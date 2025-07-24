#!/bin/sh
DIR=$(pwd)

if [ -n "$PROJECT_DIR" ]; then
  PROJECT_DIR=${PROJECT_DIR}
else
  PROJECT_DIR="$DIR"
fi

export MINT_PATH="${PROJECT_DIR}/Mint"
export MINT_LINK_PATH="${PROJECT_DIR}/Mint/bin"
