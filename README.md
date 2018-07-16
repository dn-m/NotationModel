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

### PitchSpeller

Implementation of Ben Wetherfield's `Graphical Theory of Musical Pitch Spelling`, which converts unspelled pitch values (e.g., MIDI note numbers) into spelled pitch values given context and user-specifiable rules.

### SpelledRhythm

Extends abstractly-represented rhythms with models of beams, ties, and dots.

### RhythmBeamer

Contains default algorithm for converting an abstractly-represented rhythm into a graphically renderable one.

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