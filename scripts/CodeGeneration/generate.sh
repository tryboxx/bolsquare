#!/bin/sh
DIR=$(pwd)

if [ -n "$PROJECT_DIR" ]; then
  PROJECT_DIR=${PROJECT_DIR}
else
  PROJECT_DIR="$DIR"
fi

SCRIPTS="${DIR}/scripts/CodeGeneration"

echo "PROJECT_DIR: ${PROJECT_DIR}"
echo "SCRIPTS: ${SCRIPTS}"

export PROJECT_DIR=$PROJECT_DIR
export SRCROOT=$PROJECT_DIR

${SCRIPTS}/inject-grail.sh
${SCRIPTS}/sourcery.sh
${SCRIPTS}/swiftgen.sh
${SCRIPTS}/sourcery-tests.sh
