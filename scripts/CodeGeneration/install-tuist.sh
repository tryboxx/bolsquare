#!/bin/sh

VERSION=4.36.0

export PATH="$PATH:/opt/homebrew/bin"

brew tap tuist/tuist
brew install tuist@$VERSION
brew link tuist@$VERSION --overwrite
