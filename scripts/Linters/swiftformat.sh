#!/bin/sh
DIR=$(pwd)

source $DIR/scripts/Helpers/mint-paths.sh

if [ -n "$SRCROOT" ]; then
  SRCROOT=${SRCROOT}
else
  SRCROOT="$DIR"
fi

export PATH="$PATH:/opt/homebrew/bin"

xcrun --sdk macosx mint run SwiftFormat --lint "$SRCROOT"
