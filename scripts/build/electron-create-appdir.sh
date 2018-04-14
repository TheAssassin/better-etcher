#!/bin/bash

###
# Copyright 2016 resin.io
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###

set -u
set -e

function usage() {
  echo "Usage: $0"
  echo ""
  echo "Options"
  echo ""
  echo "    -n <application name>"
  echo "    -d <application description>"
  echo "    -p <application package>"
  echo "    -r <application architecture>"
  echo "    -b <application binary name>"
  echo "    -i <application icon (.png)>"
  echo "    -o <output>"
  exit 1
}

ARGV_APPLICATION_NAME=""
ARGV_DESCRIPTION=""
ARGV_PACKAGE=""
ARGV_ARCHITECTURE=""
ARGV_BINARY=""
ARGV_ICON=""
ARGV_OUTPUT=""

while getopts ":n:d:p:r:b:i:o:" option; do
  case $option in
    n) ARGV_APPLICATION_NAME="$OPTARG" ;;
    d) ARGV_DESCRIPTION="$OPTARG" ;;
    p) ARGV_PACKAGE="$OPTARG" ;;
    r) ARGV_ARCHITECTURE="$OPTARG" ;;
    b) ARGV_BINARY="$OPTARG" ;;
    i) ARGV_ICON="$OPTARG" ;;
    o) ARGV_OUTPUT="$OPTARG" ;;
    *) usage ;;
  esac
done

if [ -z "$ARGV_APPLICATION_NAME" ] \
  || [ -z "$ARGV_DESCRIPTION" ] \
  || [ -z "$ARGV_PACKAGE" ] \
  || [ -z "$ARGV_ARCHITECTURE" ] \
  || [ -z "$ARGV_BINARY" ] \
  || [ -z "$ARGV_ICON" ] \
  || [ -z "$ARGV_OUTPUT" ]
then
  usage
fi

# Create AppDir
mkdir -p "$ARGV_OUTPUT"
APPDIR_ICON_FILENAME=icon

cat >"$ARGV_OUTPUT/$ARGV_APPLICATION_NAME.desktop" <<EOF
[Desktop Entry]
Name=$ARGV_APPLICATION_NAME
Exec=$ARGV_BINARY
Comment=$ARGV_DESCRIPTION
Icon=$APPDIR_ICON_FILENAME
Type=Application
EOF

cp "$ARGV_ICON" "$ARGV_OUTPUT/$APPDIR_ICON_FILENAME.png"
mkdir -p "$ARGV_OUTPUT/usr/bin"
cp -rf "$ARGV_PACKAGE"/* "$ARGV_OUTPUT/usr/bin"

APPRUN_GITHUB_RELEASE_BASE_URL=https://github.com/AppImage/AppImageKit/releases/download/continuous/
APPRUN_PATH="$ARGV_OUTPUT/AppRun"

if [ "$ARGV_ARCHITECTURE" == "x64" ]; then
  APPRUN_ARCHITECTURE="x86_64"
elif [ "$ARGV_ARCHITECTURE" == "x86" ]; then
  APPRUN_ARCHITECTURE="i686"
else
  echo "Invalid architecture: $ARGV_ARCHITECTURE" 1>&2
  exit 1
fi

wget "APPRUN_GITHUB_RELEASE_BASE_URL/appimagetool-$APPRUN_ARCHITECTURE.AppImage" \
    -O "$APPRUN_PATH"
chmod +x "$APPRUN_PATH"
