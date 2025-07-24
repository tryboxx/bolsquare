#!/bin/sh
DIR=$(pwd)

source $DIR/scripts/Helpers/mint-paths.sh

export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:${SRCROOT}/Mint/bin"

export INJECT_OUTPUT="${SRCROOT}/bolsquare/generated"
export INJECT_INPUT="${SRCROOT}/bolsquare"
export SOURCERY_BINPATH="xcrun --sdk macosx mint run sourcery"

export NO_MOCKS=true
export LEGACY_INJECTION=true
export IMPORTS="UIKit"
export EXTRA="--disableCache"

./Tuist/.build/checkouts/ios-inject-grail/Scripts/inject.sh
