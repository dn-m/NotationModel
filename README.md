# NotationModel

![Swift Version](https://img.shields.io/badge/Swift-4.2-orange.svg)
![Platforms](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey.svg)
[![Build Status](https://travis-ci.org/dn-m/NotationModel.svg?branch=master)](https://travis-ci.org/dn-m/NotationModel)

The `NotationModel` package contains modules for the purposes of defining a model of musical notations.

The types contained herein extend the structures defined in the [dn-m/Music](https://github.com/dn-m/Music) package, providing a rich context for abstract musical information so that it can be represented within a variety of notational media. This package remains agnostic to the concrete rendering backend.

For work on the graphical representation of music in Swift, see [dn-m/NotationView](https://github.com/dn-m/NotationView).

## Modules

### [`SpelledPitch`](https://github.com/dn-m/NotationModel/tree/master/Sources/SpelledPitch)

The `SpelledPitch` module exposes structures for describing abstract pitches (e.g., what you get if you press a key on a MIDI keyboard) with letter names and accidentals. This is done in a progressively-disclosed and type-safe manner: it is easy to describe common pitch scenarios, linearly more difficult to describe more-rare pitch scenarios, and it is impossible to describe logically-invalid pitch scenarios.

The [`Pitch.Spelling`](https://github.com/dn-m/NotationModel/blob/master/Sources/SpelledPitch/Pitch.Spelling.swift) structure provides a model of the [Helmholtz-Ellis](http://www.marcsabat.com/pdfs/notation.pdf) notation system. This notation system scales elegantly from the Western common practice [twelve-note equal division of the octave](https://en.wikipedia.org/wiki/Equal_temperament) tuning system to that of high-limit [just intonation](https://en.wikipedia.org/wiki/Just_intonation). This system is represented in the [SMuFL specification](http://www.smufl.org/version/1.2/range/extendedHelmholtzEllisAccidentalsJustIntonation/), making a mapping of these structures into a rendering context as seamless as possible.

### [`SpelledRhythm`](https://github.com/dn-m/NotationModel/tree/master/Sources/SpelledRhythm)

The `SpelledRhythm` module defines models of beams, ties, and dots.

### [`PlotModel`](https://github.com/dn-m/NotationModel/tree/master/Sources/PlotModel)

Defines a model for positioning values onto two-dimensional plots.

### [`StaffModel`](https://github.com/dn-m/NotationModel/tree/master/Sources/StaffModel)

Extends the `PlotModel`, incorporating the concept of clefs, noteheads, accidentals, etc.

## Development

Work on this package requires Swift 4.2.

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
