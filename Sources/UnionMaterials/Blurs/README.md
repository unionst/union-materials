## Overview

Standard SwiftUI blur modifiers apply uniform blur across entire views. 

### Available Blur Types

- **`BlurView`**: Customizable uniform blur with adjustable radius
- **`ProgressiveBlurView`**: Variable intensity blur that transitions from clear to blurred
- **`InvisibleMaterial`**: Alternative to SwiftUI materials with customizable opacity and blur levels

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

### InvisibleMaterial

An alternative to SwiftUI's built-in materials that provides more control over blur and opacity levels. Available for iOS 15.0+, macOS 12.0+, tvOS 15.0+, watchOS 8.0+.

**Usage as View:**
```swift
import SwiftUI
import UnionMaterials

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            Text("Frosted Content")
                .font(.headline)
                .padding()
                .background(InvisibleMaterial(.regular))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
```

**Usage as ShapeStyle:**
```swift
import SwiftUI
import UnionMaterials

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            VStack(spacing: 16) {
                Text("Ultra Thin")
                    .padding()
                    .background(.ultraThinInvisibleMaterial, in: RoundedRectangle(cornerRadius: 8))
                
                Text("Regular")
                    .padding()
                    .background(.regularInvisibleMaterial, in: RoundedRectangle(cornerRadius: 8))
                
                Text("Thick")
                    .padding()
                    .background(.thickInvisibleMaterial, in: RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}
```

**Available Styles:**
- `.ultraThin`: Minimal blur (radius: 1, opacity: 0.05)
- `.thin`: Light blur (radius: 3, opacity: 0.1)
- `.regular`: Standard blur (radius: 8, opacity: 0.2)
- `.thick`: Heavy blur (radius: 20, opacity: 0.35)
- `.ultraThick`: Maximum blur (radius: 35, opacity: 0.5)
- `.bar`: Tab/navigation bar style (radius: 6, opacity: 0.15)

**ShapeStyle Extensions:**
- `.ultraThinInvisibleMaterial`
- `.thinInvisibleMaterial`
- `.regularInvisibleMaterial`
- `.thickInvisibleMaterial`
- `.ultraThickInvisibleMaterial`
- `.barInvisibleMaterial`
