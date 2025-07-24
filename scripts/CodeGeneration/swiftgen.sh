#!/bin/sh
DIR=$(pwd)

source $DIR/scripts/Helpers/mint-paths.sh

if [ -n "$PROJECT_DIR" ]; then
  PROJECT_DIR=${PROJECT_DIR}
else
  PROJECT_DIR="$DIR"
fi

export PATH="$PATH:/opt/homebrew/bin"

xcrun --sdk macosx mint run SwiftGen config run --config "${PROJECT_DIR}/.swiftgen.yml"
