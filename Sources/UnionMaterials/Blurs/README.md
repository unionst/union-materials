## Overview

Standard SwiftUI blur modifiers apply uniform blur across entire views. 

### Available Blur Types

- **`BlurView`**: Customizable uniform blur with adjustable radius
- **`ProgressiveBlurView`**: Variable intensity blur that transitions from clear to blurred

## Usage

### BlurView

A simple blur view wrapper that applies a customizable blur radius.

**Usage:**
```swift
import SwiftUI
import UnionMaterials

struct ContentView: View {
    var body: some View {
        ZStack {
            // Background content
            Image("backgroundImage")
            
            // Blur overlay
            BlurView(radius: 20)
                .frame(width: 200, height: 100)
                .cornerRadius(12)
        }
    }
}
```

**Parameters:**
- `radius`: The blur radius to apply (default: 20). Higher values create stronger blur effects.

### ProgressiveBlurView

Creates a gradient blur effect that transitions from clear to blurred, allowing for increased legibility and depth.

**Usage:**
```swift
import SwiftUI
import UnionMaterials

struct ContentView: View {
    var body: some View {
        ZStack {
            // Content to blur
            ScrollView {
                ForEach(0..<50) { i in
                    Text("Item \(i)")
                        .padding()
                }
            }
            
            // Progressive blur overlay at top
            VStack {
                ProgressiveBlurView(
                    maxBlurRadius: 30,
                    direction: .blurredTopClearBottom,
                    startOffset: -0.1
                )
                .frame(height: 100)
                
                Spacer()
            }
        }
    }
}
```

**Parameters:**
- `maxBlurRadius`: Maximum blur intensity at the strongest point (default: 20)
- `direction`: Direction of the blur gradient:
  - `.blurredTopClearBottom`: Blurred at top, clear at bottom
  - `.blurredBottomClearTop`: Blurred at bottom, clear at top
- `startOffset`: Offset coefficient for the blur start point (default: 0). Negative values (-0.1) create a more gradual transition
