# Hanoi

A Swift library and command-line tool for solving and working with the Tower of Hanoi problem.

## Overview

Hanoi provides a reusable Swift package for generating and exploring Tower of Hanoi solutions.

The package contains:

* **HanoiCore** — the core library containing the Tower of Hanoi logic.
* **hanoi** — a command-line interface for solving the Tower from the terminal.

## Package Installation

### Swift Package Manager

Add Hanoi as a dependency in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/jackr4bbit/Hanoi", from: "1.0.0")
]
```

Then add `HanoiCore` to your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        "HanoiCore"
    ]
)
```

## CLI Installation

### Download (easy)
Download the release for your platform from the releases page. Then run `chmod +x FILENAME` and move it to any location on your path.

After building the package:

```bash
swift build -c release
```

Run the CLI:

```bash
.build/release/hanoi
```

### Building From Source

Requirements:

* Swift 5.7 or newer
* macOS, Linux, or Windows with a supported Swift toolchain

Clone the repository:

```bash
git clone https://github.com/jackr4bbit/Hanoi.git
cd Hanoi
```

Build the release executable:

```bash
swift build --configuration release --product hanoi
```

Find where Swift output the binary:
```bash
swift build --configuration release --product hanoi --show-bin-path
```

## Documentation

API documentation is generated using Swift-DocC.

The latest documentation is available at <https://jackhuey.com/hanoi/documentation/hanoicore/>.
