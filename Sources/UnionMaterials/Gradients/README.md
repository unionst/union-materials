## Overview

Standard linear gradients use a constant rate of change between colors, which can sometimes appear flat or unnatural, especially for UI elements and animations.

### Available Gradient Types

- **`LinearGradient`** (SwiftUI built-in): Constant rate of change, good for basic needs
- **`ExponentialGradient`**: Power function curves that mimic how light behaves in physical space
- **`SmoothGradient`**: Mathematical smoothstep functions with zero derivatives at endpoints, creating the most natural-looking UI transitions

### When to Use Each Type

| Gradient Type | Best For | Visual Characteristic |
|---------------|----------|----------------------|
| `LinearGradient` | Simple backgrounds, basic effects | Uniform transition |
| `ExponentialGradient` | Lighting effects, depth simulation | Curved acceleration |
| `SmoothGradient` | Buttons, cards, modern UI elements | Gentle start/end, natural feel |

## Usage

### ExponentialGradient

```swift
import SwiftUI
import UnionGradients

struct ContentView: View {
    var body: some View {
        ExponentialGradient(
            colors: [.blue, .purple],
            startPoint: .leading, 
            endPoint: .trailing,
            exponent: 2.0
        )
        .frame(width: 300, height: 200)
    }
}
```

### SmoothGradient

```swift
import SwiftUI
import UnionGradients

struct ContentView: View {
    var body: some View {
        SmoothGradient(
            colors: [.blue, .purple],
            startPoint: .leading, 
            endPoint: .trailing,
            smoothType: .smootherstep
        )
        .frame(width: 300, height: 200)
    }
}
```

### Comparison Example

```swift
struct GradientComparison: View {
    var body: some View {
        VStack(spacing: 20) {
            // Standard linear gradient
            LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
                .frame(height: 60)
                .overlay(Text("Linear").foregroundStyle(.white))
            
            // Exponential gradient
            ExponentialGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing, exponent: 2.0)
                .frame(height: 60)
                .overlay(Text("Exponential").foregroundStyle(.white))
            
            // Smooth gradient
            SmoothGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing, smoothType: .smootherstep)
                .frame(height: 60)
                .overlay(Text("Smooth").foregroundStyle(.white))
        }
        .padding()
    }
}
```

### Advanced UI Examples

```swift
struct ModernUI: View {
    var body: some View {
        VStack(spacing: 24) {
            // Glass card with smooth gradient
            VStack(spacing: 16) {
                Text("Glass Card")
                    .font(.headline)
                Text("With smooth gradient background")
                    .font(.subheadline)
                    .opacity(0.8)
            }
            .padding(24)
            .background {
                SmoothGradient(
                    stops: [
                        .init(color: .white.opacity(0.1), location: 0.0),
                        .init(color: .white.opacity(0.2), location: 0.5),
                        .init(color: .white.opacity(0.1), location: 1.0)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing,
                    smoothType: .smootherstep
                )
            }
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            // Smooth button
            Button("Beautiful Button") {
                // action
            }
            .foregroundStyle(.white)
            .font(.headline)
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
            .background {
                SmoothGradient(
                    colors: [.blue, .purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .blue.opacity(0.3), radius: 8, y: 4)
        }
        .padding()
    }
}
```

## Parameters

### Common Parameters
- `gradient`: A SwiftUI Gradient to use for the colors.
- `colors`: An array of Colors to use in the gradient (convenience initializer).
- `stops`: An array of Gradient.Stop values for precise color control (convenience initializer).
- `startPoint`: The UnitPoint where the gradient begins.
- `endPoint`: The UnitPoint where the gradient ends.
- `subdivisions`: The number of gradient steps to use (default: 32, higher values create smoother gradients).

### ExponentialGradient
- `exponent`: The power to which the interpolation is raised (default: 2.0).
  - Values > 1 create a slower start and faster finish
  - Values < 1 create a faster start and slower finish
  - Value of 1 is equivalent to a linear gradient

### SmoothGradient
- `smoothType`: The type of smoothstep function to use (default: .smootherstep).
  - `.smoothstep`: 3rd-order polynomial with zero first derivatives at endpoints - basic smooth transitions
  - `.smootherstep`: 5th-order polynomial with zero first and second derivatives at endpoints (recommended) - excellent for UI
  - `.smootheststep`: 7th-order polynomial with zero first, second, and third derivatives at endpoints - maximum smoothness

## Mathematical Functions

The library also provides `MathFunctions` for custom gradient implementations:

```swift
// Available smoothstep functions
let smooth = MathFunctions.smoothstep(0.5)        // Basic smooth curve
let smoother = MathFunctions.smootherstep(0.5)    // Enhanced smoothness 
let smoothest = MathFunctions.smootheststep(0.5)  // Maximum smoothness

// Easing functions for different effects
let easeInOut = MathFunctions.easeInOut(0.5)         // Quadratic ease
let cubicEase = MathFunctions.easeInOutCubic(0.5)    // Cubic ease
let sineEase = MathFunctions.sine(0.5)               // Sine-based ease
let cosineEase = MathFunctions.cosine(0.5)           // Cosine-based ease
```

## Performance

All gradients are optimized for real-time use:

- **SmoothGradient**: Excellent performance, recommended for UI elements
- **ExponentialGradient**: Good performance, suitable for backgrounds and animations
- **Subdivisions**: Higher values (64, 128) create smoother gradients but use more memory

## Visual Guide

### Function Curves Comparison

The smoothstep functions create different curve shapes:

- **Linear**: Straight line from (0,0) to (1,1)
- **Smoothstep**: S-curve with zero derivatives at endpoints
- **Smootherstep**: More pronounced S-curve with zero 1st and 2nd derivatives
- **Smootheststep**: Most gradual S-curve with zero 1st, 2nd, and 3rd derivatives

### Recommended Usage

- **Buttons & Interactive Elements**: `SmoothGradient` with `.smootherstep`
- **Background Gradients**: `ExponentialGradient` with exponent 1.5-3.0
- **Card Backgrounds**: `SmoothGradient` with subtle colors and `.smootherstep`
- **Glass Effects**: `SmoothGradient` with opacity gradients and `.smootherstep`
