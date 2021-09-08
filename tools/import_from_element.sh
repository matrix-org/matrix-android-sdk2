#!/usr/bin/env bash

### This script import SDK code from Element Android

set -e

elementAndroidPath="../element-android"

if [ -d "$elementAndroidPath" ]; then
  echo "Importing sdk module from Element Android located at ${elementAndroidPath}"
else
  echo "Element Android not found at ${elementAndroidPath}. Can not continue."
  exit 1
fi

# Check that Element Android is on main branch

pushd $elementAndroidPath

elementBranch=`git rev-parse --abbrev-ref HEAD`

if [ "$elementBranch" != "main" ]; then
  read -p "Warning, Element Android is not on main branch but on branch '${elementBranch}' . Continue (y/n)? " -n 1 CONT
  echo
  if [ "$CONT" != "y" ]; then
    exit 0
  fi
fi

popd

# matrix SDK

# Delete existing path
echo "Importing matrix-sdk-android..."
rm -rf ./matrix-sdk-android
cp -r ${elementAndroidPath}/matrix-sdk-android .

# Add all changes to git
git add -A

read -p "Press enter to build the library (update the version first?)"

# Build the library
./gradlew clean assembleRelease --stacktrace

# Success

echo "Success"
echo
echo "Please check the version name before committing and update the changelog"