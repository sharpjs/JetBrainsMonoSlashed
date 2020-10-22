<#
.SYNOPSIS
    Build Script for JetBrains Mono Slashed

.DESCRIPTION
    (none)

.INPUTS
    None

.OUTPUTS
    None

.NOTES
    Copyright 2020 Subatomix Research Inc
    SPDX-License-Identifier: Apache-2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

.LINK
    JetBrains Mono:         https://github.com/JetBrains/JetBrainsMono
    JetBrains Mono Slashed: https://github.com/sharpjs/JetBrainsMonoSlashed
#>

#Requires -Version 5.1
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

# Run remainder of build in an ephemeral Docker container
& docker run -t --rm        `
    -e VERSION=2.200        `
    -v ${PSScriptRoot}:/src `
    python:alpine           `
    /src/build.sh

if ($LASTEXITCODE -ne 0) {
    throw "docker run failed with exit code $LASTEXITCODE."
}
