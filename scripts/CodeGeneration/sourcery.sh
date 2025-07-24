#!/bin/sh
DIR=$(pwd)

source $DIR/scripts/Helpers/mint-paths.sh

if [ -n "$PROJECT_DIR" ]; then
  PROJECT_DIR=${PROJECT_DIR}
else
  PROJECT_DIR="$DIR"
fi

export PATH="$PATH:/opt/homebrew/bin"

mkdir -p "${PROJECT_DIR}/bolsquare/generated/"

xcrun --sdk macosx mint run Sourcery --config "${PROJECT_DIR}/tools/sourcery/bolsquare/sourcery.yml"
