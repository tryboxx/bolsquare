#!/bin/bash

date=$(git log -1 --date=format:"%y%m%d" --format="%ad")
hour=$(git log -1 --date=format:"%H%M" --format="%ad")
#appVersion=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}/Info.plist")
env

version=$date.$hour
if [[ -z ${CIRCLE_TAG} ]]; then
  echo "No circle tag"
else
  if [[ $CIRCLE_TAG == experimental-v.* ]]; then
    echo "Has circle tag ${CIRCLE_TAG}"  
    version=$date.$hour.experimental
  fi
fi

echo "VERSION: $version"

infoPath="${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
dsymInfoPath="${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Info.plis"

echo "Info.plist path: $infoPath"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $version" "$infoPath"
if [ -f "$dsymInfoPath" ]; then
echo "dSYM Info.plist path: $dsymInfoPath"
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $version" "$dsymInfoPath"
fi
