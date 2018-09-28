# NotationModel

![Swift Version](https://img.shields.io/badge/Swift-4.2-brightgreen.svg)
[![Build Status](https://travis-ci.org/dn-m/NotationModel.svg?branch=master)](https://travis-ci.org/dn-m/NotationModel)

The `NotationModel` package contains several modules for the purposes of defining a model of musical notations. It extends types defined in the [`dn-m/Music`](https://github.com/dn-m/Music) module.

## Modules

### PlotModel

Defines a model for positioning values onto two-dimensional plots.

### StaffModel

Extends the `PlotModel`, incorporating the concept of clefs, noteheads, accidentals, etc.

### SpelledPitch

Defines pitches with names (`G Sharp`, `A Flat`, `B Double Sharp`, etc.) as well as named intervals (`Major Third`, `Perfect Fifth`, `Double Augmented Sixth`, etc.).

### SpelledRhythm

Extends abstractly-represented rhythms with models of beams, ties, and dots.

## Development

Work on this branch requires Swift 4.2.

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

The `NotationModel` package contains several modules:

- [`SpelledPitch`](https://github.com/dn-m/NotationModel/tree/master/Sources/SpelledPitch)
- [`SpelledRhythm`](https://github.com/dn-m/NotationModel/tree/master/Sources/SpelledRhythm)
- [`PlotModel`](https://github.com/dn-m/NotationModel/tree/master/Sources/PlotModel)
- [`StaffModel`](https://github.com/dn-m/NotationModel/tree/master/Sources/StaffModel)
