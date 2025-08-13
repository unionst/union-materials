# UnionMaterials

A SwiftUI extension that offers custom gradients and blur effects for creating sophisticated user interfaces.

## Overview

- **[Gradients](Sources/UnionMaterials/Gradients/README.md)**: Various gradients (i.e exponential and smooth) for more natural-looking color transitions
- **[Blurs](Sources/UnionMaterials/Blurs/README.md)**: Various blur effects including progressive blurs and backdrop views

## Requirements

- iOS 14.0+
- macOS 11.0+
- tvOS 14.0+
- watchOS 7.0+

## Installation

### Swift Package Manager

Add the package dependency to your Package.swift file:

```swift
dependencies: [
    .package(url: "https://github.com/unionst/union-materials.git", from: "1.0.0")
]
```

Or add it directly in Xcode using File > Add Packages...

## Components

### Gradient Components
- `ExponentialGradient`: Creates exponential gradients for natural color transitions
- `Color+Util`: Color utility extensions for gradient manipulation

### Blur Components
- `BlurView`: Standard blur view with customizable intensity
- `ProgressiveBlurView`: Variable intensity blur across the view

## License

This library is released under the MIT license. See LICENSE for details.
