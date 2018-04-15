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

OS=$(uname)
if [[ "$OS" != "Linux" ]]; then
  echo "This script is only meant to be run in GNU/Linux" 1>&2
  exit 1
fi

function usage() {
  echo "Usage: $0"
  echo ""
  echo "Options"
  echo ""
  echo "    -d <appdir>"
  echo "    -r <application architecture>"
  echo "    -w <download directory>"
  echo "    -o <output>"
  exit 1
}

ARGV_APPDIR=""
ARGV_ARCHITECTURE=""
ARGV_DOWNLOAD_DIRECTORY=""
ARGV_OUTPUT=""

while getopts ":d:r:w:o:" option; do
  case $option in
    d) ARGV_APPDIR="$OPTARG" ;;
    r) ARGV_ARCHITECTURE="$OPTARG" ;;
    w) ARGV_DOWNLOAD_DIRECTORY="$OPTARG" ;;
    o) ARGV_OUTPUT="$OPTARG" ;;
    *) usage ;;
  esac
done

if [ -z "$ARGV_APPDIR" ] \
  || [ -z "$ARGV_ARCHITECTURE" ] \
  || [ -z "$ARGV_DOWNLOAD_DIRECTORY" ] \
  || [ -z "$ARGV_OUTPUT" ]
then
  usage
fi

if [ "$ARGV_ARCHITECTURE" == "x64" ]; then
  APPIMAGETOOL_ARCHITECTURE="x86_64"
elif [ "$ARGV_ARCHITECTURE" == "x86" ]; then
  APPIMAGETOOL_ARCHITECTURE="i686"
else
  echo "Invalid architecture: $ARGV_ARCHITECTURE" 1>&2
  exit 1
fi

APPIMAGETOOL_GITHUB_RELEASE_BASE_URL=https://github.com/AppImage/AppImageKit/releases/download/continuous/
APPIMAGETOOL_PATH="$ARGV_DOWNLOAD_DIRECTORY/appimagetool-$ARGV_ARCHITECTURE.AppImage"

curl "$APPIMAGETOOL_GITHUB_RELEASE_BASE_URL/appimagetool-$APPIMAGETOOL_ARCHITECTURE.AppImage" \
    -L -o "$APPIMAGETOOL_PATH"
chmod +x "$APPIMAGETOOL_PATH"

# Generate AppImage
mkdir -p $(dirname "$ARGV_OUTPUT")
"$APPIMAGETOOL_PATH" "$ARGV_APPDIR" "$ARGV_OUTPUT" -u "gh-releases-zsync|TheAssassin|better-etcher|continuous|*etcher*$APPIMAGETOOL_ARCHITECTURE*.AppImage.zsync"
