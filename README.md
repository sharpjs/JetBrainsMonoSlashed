# JetBrains Mono Slashed

The [JetBrains Mono](https://jetbrains.com/mono) font, with slashed zero made
the default.

**JetBrains Mono** provides slashed zero as an optional OpenType feature, but
few programs know how to discover and enable OpenType features. **JetBrains
Mono Slashed** makes the feature enabled by default, so that all programs can
display slashed zero.

JetBrains Mono is developed [on GitHub](https://github.com/JetBrains/JetBrainsMono).

## Installation

- Download the `JetBrainsMonoSlashed-<version>.zip` file from the 
  [latest release](https://github.com/sharpjs/JetBrainsMonoSlashed/releases/latest).

- Extract the `.otf` files therein, and install them on your system manually.

## Building

A working `docker` command is required.

If you have PowerShell 5.1 or later, just run the `build.ps1` script.
This should work on all major platforms.

Alternatively, you can run the containerized build directly.  In `sh`, `bash`,
`zsh`, etc., the command is:

```sh
docker run -t --rm -e VERSION=2.304 -v "$PWD:/src" python:alpine /src/build.sh
```

In PowerShell, the command is:

```sh
docker run -t --rm -e VERSION=2.304 -v ${PWD}:/src python:alpine /src/build.sh
```

## License

The code in this repository is available under the
[Apache License v2.0](https://www.apache.org/licenses/LICENSE-2.0).

JetBrains Mono and JetBrains Mono Slashed typefaces are available under the
[SIL Open Font License v1.1](https://github.com/JetBrains/JetBrainsMono/blob/v2.200/OFL.txt)
and may be used free of charge, for both commercial and non-commercial
purposes. You do not need to give credit to JetBrains, although they will
appreciate it very much if you do. 

JetBrains Mono Slashed uses the name "JetBrains Mono"
[with permission](https://github.com/JetBrains/JetBrainsMono/issues/295).

`SPDX-License-Identifier: Apache-2.0`

## Credits

**Type designer**\
Philipp Nurullin

**Team lead**\
Konstantin Bulenkov

**Thanks to**\
Nikita Prokopov\
Eugene Auduchinok\
Tatiana Tulupenko\
Dmitrij Batrak\
IntelliJ Platform UX Team\
Web Team
