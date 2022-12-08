#!/usr/bin/env bash

#
# Copyright (c) 2022 New Vector Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Ignore any error to not stop the script
set +e

printf "\n"
printf "================================================================================\n"
printf "|                    Welcome to the release script!                            |\n"
printf "================================================================================\n"

# Guessing version to propose a default version
printf "\nGuessing the version...\n"
# Get the version from the latest main from Element
# curl -s  https://raw.githubusercontent.com/vector-im/element-android/main/matrix-sdk-android/build.gradle |grep "SDK_VERSION" |cut -d "\"" -f7|cut -d "\\" -f1
versionCandidate=`curl -s https://raw.githubusercontent.com/vector-im/element-android/main/matrix-sdk-android/build.gradle | grep SDK_VERSION | cut -d "\"" -f7 | cut -d "\\\\" -f1`

printf "\n"
read -p "Please enter the release version (example: ${versionCandidate}). Just press enter if ${versionCandidate} is correct. " version
version=${version:-${versionCandidate}}

printf "\n================================================================================\n"
printf "Ensuring main and develop branches are up to date...\n"

git checkout main
git pull
git checkout develop
git pull

printf "\n================================================================================\n"
printf "Starting the release ${version}\n"
git flow release start ${version}

# Note: in case the release is already started and the script is started again, checkout the release branch again.
ret=$?
if [[ $ret -ne 0 ]]; then
  printf "Mmh, it seems that the release is already started. Checking out the release branch...\n"
  git checkout "release/${version}"
fi

printf "\n================================================================================\n"
printf "Updating version to ${version}\n"

cp ./gradle.properties ./gradle.properties.bak
sed "s/VERSION_NAME=.*$/VERSION_NAME=${version}/" ./gradle.properties.bak > ./gradle.properties
rm ./gradle.properties.bak
git commit -a -m "Setting version for the release ${version}"

printf "\n================================================================================\n"
printf "Downloading Element Android source ${version}...\n"

curl  https://github.com/vector-im/element-android/archive/refs/tags/v${version}.zip -i -L -o ./tmp/release.zip

printf "\n================================================================================\n"
printf "Unzipping Element Android source ${version}...\n"

# Delete existing path if any
if [[ -e "./tmp/element-android-${version}" ]]; then
  rm -rf ./tmp/element-android-${version}
fi

unzip -q ./tmp/release.zip -d ./tmp/

printf "\n================================================================================\n"
printf "Importing the module matrix-sdk-android...\n"
elementAndroidPath="./tmp/element-android-${version}"
# Delete existing path
rm -rf ./matrix-sdk-android
cp -r ${elementAndroidPath}/matrix-sdk-android .

# Copy other files
cp -r ${elementAndroidPath}/gradle/wrapper/gradle-wrapper.properties ./gradle/wrapper/gradle-wrapper.properties
cp -r ${elementAndroidPath}/dependencies.gradle .
cp -r ${elementAndroidPath}/dependencies_groups.gradle .

# Add all changes to git
git add -A

## Check the number of diff in the file ./matrix-sdk-android/build.gradle. If 2 we can revert it, else it will have to be done manually
nbDiff=`git diff --staged ./matrix-sdk-android/build.gradle | grep "@@" | wc -l | cut -d " " -f8`
if [[ ${nbDiff} -ne 2 ]]; then
  printf "\n================================================================================\n"
  read -p "Cannot reset file ./matrix-sdk-android/build.gradle automatically. Please check the diff, and restore some part. Press enter when it's done "
else
  git reset ./matrix-sdk-android/build.gradle
  git restore ./matrix-sdk-android/build.gradle
fi

# Add all changes to git
git add -A

printf "\n================================================================================\n"
printf "Building the library.\n"

# Do not ignore errors
set -e
# Build the library
./gradlew clean assembleRelease --stacktrace
set +e

printf "\n================================================================================\n"
read -p "OK, I will commit the changes, press Enter to continue "
git commit -a -m "Import v${version} from Element Android"

printf "\n================================================================================\n"
printf "Preparing CHANGES.md file. You can copy this block at the top of the file, and import the part about SDK change from Element Android. Do not commit.\n\n"

date=`date +%Y-%m-%d`
printf "Changes in Matrix-SDK v${version} (${date})\n"
printf "=========================================\n"
printf "\n"
printf "Imported from Element ${version}. (https://github.com/vector-im/element-android/releases/tag/v${version})\n"
printf "\n"
printf "SDK API changes ⚠️\n"
# TIL
printf -- "------------------\n"
printf "TODO COPY PASTE BLOCK FROM ELEMENT AT https://raw.githubusercontent.com/vector-im/element-android/main/CHANGES.md\n"
printf "\n"
printf "\n"

read -p "Press Enter when it's done, I will do the commit. "

printf "Committing...\n"
git commit -a -m "Changelog for version ${version}"

printf "\n================================================================================\n"
printf "OK, finishing the release...\n"
git flow release finish "${version}"

printf "\n================================================================================\n"
read -p "Done, push the branch 'main' and the new tag (yes/no) default to yes? " doPush
doPush=${doPush:-yes}

if [ ${doPush} == "yes" ]; then
  printf "Pushing branch 'main' and tag 'v${version}'...\n"
  git push origin main
  git push origin "v${version}"
else
    printf "Not pushing, do not forget to push manually!\n"
fi

printf "\n================================================================================\n"
printf "Checking out develop...\n"
git checkout develop

printf "\n================================================================================\n"
read -p "Done, push the branch 'develop' (yes/no) default to yes? (A rebase may be necessary in case develop got new commits)" doPush
doPush=${doPush:-yes}

if [ ${doPush} == "yes" ]; then
  printf "Pushing branch 'develop'...\n"
  git push origin develop
else
    printf "Not pushing, do not forget to push manually!\n"
fi

printf "\n================================================================================\n"
printf "Going back to main branch to release the library...\n"
git checkout main

printf "\n================================================================================\n"
printf "Building and releasing the library...\n"
./gradlew clean publish --no-daemon --no-parallel
./gradlew closeAndReleaseRepository

printf "\n================================================================================\n"
printf "Downloading the aar from MavenCentral (from https://repo1.maven.org/maven2/org/matrix/android/matrix-android-sdk2/)...\n"

aarFile="matrix-android-sdk2-${version}.aar"
command="curl --fail https://repo1.maven.org/maven2/org/matrix/android/matrix-android-sdk2/${version}/${aarFile} -s -i -L -o ./tmp/${aarFile}"
${command}
while [[ $? -ne 0 ]]
do
  printf "Not available yet, waiting 30s and retrying...\n"
  sleep 30
  ${command}
done

printf "\n================================================================================\n"
read -p "Create the release on gitHub from the tag https://github.com/matrix-org/matrix-android-sdk2/tags, copy paste the block from the file CHANGES.md. Press enter when it's done."
read -p "Add the aar ${aarFile} to the GitHub release. It has been downloaded in the folder ./tmp. Press enter when it's done."

printf "\n================================================================================\n"
printf "Congratulation! Kudos for using this script! Have a nice day!\n"
printf "================================================================================\n"
