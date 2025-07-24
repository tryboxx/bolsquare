#!/bin/sh
DIR=$(pwd)

source $DIR/scripts/Helpers/mint-paths.sh

if which mint > /dev/null; then
  echo "mint already installed"
else
  echo "installing mint"
  brew install mint
  echo "mint installed"
fi

mint bootstrap --link --overwrite y
