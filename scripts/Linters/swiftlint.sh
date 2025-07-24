#!/bin/sh
DIR=$(pwd)

source $DIR/scripts/Helpers/mint-paths.sh

export PATH="$PATH:/opt/homebrew/bin"

xcrun --sdk macosx mint run SwiftLint --strict
