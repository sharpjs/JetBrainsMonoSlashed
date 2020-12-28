#!/bin/sh -e
#
# In-Container Build Script for JetBrains Mono Slashed
# Copyright 2020 Subatomix Research Inc
# SPDX-License-Identifier: Apache-2.0
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

# Validate environment
if [ -z "$VERSION" ]; then
  echo 'ERROR: $VERSION must be set to the JetBrains Mono version.' 1>&2
  exit 1
fi

# Set names
SRC_NAME="JetBrainsMono"
DST_NAME="JetBrainsMonoSlashed"
SRC_ZIP="${SRC_NAME}-${VERSION}.zip"
DST_ZIP="${DST_NAME}-${VERSION}.zip"
SRC_URL="https://github.com/JetBrains/JetBrainsMono/releases/download/v${VERSION}/${SRC_ZIP}"

# Install updates and dependencies
apk update
apk upgrade
apk add zip
python -m pip install --upgrade pip
pip install fonttools opentype-feature-freezer

# -----------------------------------------------------------------------------
# Phase 1: Acquire Input

# Prepare source directory
mkdir -p /build/in
cd /build/in

# Download source
echo "Downloading $SRC_URL"
[ -f "$SRC_ZIP" ] || wget "$SRC_URL" 2>&1

# Unpack source
echo "Unpacking $SRC_ZIP"
unzip -j "$SRC_ZIP" "*.ttf" "*.txt"

# Add zero feature to NL fonts
for src in *NL-*.ttf; do
  echo "$src <- zero feature"
  fonttools feaLib -o "$src" /src/zero.fea "$src"
done

# -----------------------------------------------------------------------------
# Phase 2: Input -> Output

# Prepare output directory
mkdir -p /build/out
cd /build

# Copy license
mv in/OFL.txt out/LICENSE.txt
mv in/*.txt   out

# Slash zeros
for src in in/*.ttf; do
  dst="out/${DST_NAME}${src#in/$SRC_NAME}"
  dst="${dst%.ttf}.otf"
  echo "$src -> $dst"
  pyftfeatfreeze -f zero -i -S -U Slashed "$src" "$dst"
done

# -----------------------------------------------------------------------------
# Phase 3: Output -> Package

# Prepare package directory
mkdir -p /src/dist
cd /build/out

# Organize
mkdir -p No-Ligatures Variable
mv "${DST_NAME}NL"*        No-Ligatures
mv "${DST_NAME}"*"[wght]"* Variable

# Package
echo "Packing $DST_ZIP"
DST_PATH="/src/dist/${DST_ZIP}"
[ ! -f "$DST_PATH" ] || rm "$DST_PATH"
zip -r9 "$DST_PATH" .
