# NotationModel

[![Build Status](https://travis-ci.org/dn-m/NotationModel.svg?branch=master)](https://travis-ci.org/dn-m/NotationModel)

Model of musical notation.

## Development

Work on this branch requires the Swift 4.2 toolchain, via Xcode 10 beta, or [development snapshot](https://swift.org/download/#snapshots).

### Build instructions

Clone the repo.

```Bash
git clone https://github.com/dn-m/NotationModel
```

Dive inside.

```Bash
cd NotationModel
```

Ask [Swift Package Manager](https://swift.org/package-manager/) to update dependencies (all are `dn-m`).

```Bash
swift package update
```

Compiles code and runs tests in terminal.

```Bash
swift test
```

Ask Swift Package Manager to generate a nice Xcode project.

```Bash
swift package generate-xcodeproj
```

Open it up.

```Bash
open NotationModel.xcodeproj/
```