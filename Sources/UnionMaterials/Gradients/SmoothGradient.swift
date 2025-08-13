//
//  SmoothGradient.swift
//  union-gradients
//
//  Created by Ben Sage on 4/9/25.
//

import SwiftUI

/// The type of smoothstep function to use for gradient interpolation.
///
/// These mathematical functions provide smooth transitions with zero derivatives at both endpoints,
/// creating visually pleasing gradients that start and end gently without abrupt changes.
///
/// ## Mathematical Properties
///
/// All smoothstep functions:
/// - Map input range [0, 1] to output range [0, 1]
/// - Have zero first derivative at both t=0 and t=1
/// - Create S-shaped curves that are smooth at the endpoints
///
/// ## Visual Characteristics
///
/// - **smoothstep**: Basic smooth transition, good performance
/// - **smootherstep**: Recommended for most UI gradients, excellent smoothness
/// - **smootheststep**: Maximum mathematical smoothness, subtle visual difference
///
/// ## Example
///
/// ```swift
/// VStack(spacing: 20) {
///     // Compare different smoothness levels
///     SmoothGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing, smoothType: .smoothstep)
///         .frame(height: 60)
///     
///     SmoothGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing, smoothType: .smootherstep)
///         .frame(height: 60)
///     
///     SmoothGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing, smoothType: .smootheststep)
///         .frame(height: 60)
/// }
/// ```
public enum SmoothStepType {
    /// 3rd-order polynomial smoothstep function: f(t) = 3t² - 2t³
    ///
    /// Provides basic smooth interpolation with zero first derivatives at endpoints.
    /// This is the classic smoothstep function used in computer graphics.
    ///
    /// **Performance**: Fastest of the three options
    /// **Use case**: When you need smooth transitions with minimal computational overhead
    case smoothstep
    
    /// 5th-order polynomial smootherstep function: f(t) = 6t⁵ - 15t⁴ + 10t³
    ///
    /// Provides enhanced smooth interpolation with zero first and second derivatives at endpoints.
    /// This creates even smoother visual transitions than smoothstep.
    ///
    /// **Performance**: Good balance of smoothness and speed
    /// **Use case**: Recommended for most UI gradients - provides excellent visual results
    case smootherstep
    
    /// 7th-order polynomial smootheststep function: f(t) = -20t⁷ + 70t⁶ - 84t⁵ + 35t⁴
    ///
    /// Provides maximum smooth interpolation with zero first, second, and third derivatives at endpoints.
    /// Creates the mathematically smoothest possible transition.
    ///
    /// **Performance**: Slowest but still very fast for UI purposes
    /// **Use case**: When you need the absolute smoothest possible gradient
    case smootheststep
    
    func apply(to t: CGFloat) -> CGFloat {
        let clamped = max(0, min(1, t))
        switch self {
        case .smoothstep:
            return 3 * clamped * clamped - 2 * clamped * clamped * clamped
        case .smootherstep:
            let t3 = clamped * clamped * clamped
            let t4 = t3 * clamped
            let t5 = t4 * clamped
            return 6 * t5 - 15 * t4 + 10 * t3
        case .smootheststep:
            let t3 = clamped * clamped * clamped
            let t4 = t3 * clamped
            let t5 = t4 * clamped
            let t6 = t5 * clamped
            let t7 = t6 * clamped
            return -20 * t7 + 70 * t6 - 84 * t5 + 35 * t4
        }
    }
}

/// A gradient that uses mathematical smoothstep functions for natural-looking color transitions.
///
/// Unlike standard linear gradients that have constant rate of change, `SmoothGradient` uses
/// polynomial functions with zero derivatives at both endpoints, creating smooth S-shaped
/// interpolation curves that eliminate abrupt visual changes at gradient boundaries.
///
/// ## Key Benefits
///
/// - **Zero derivatives at endpoints**: Gradients start and end gently
/// - **Visually natural**: Mimics how our eyes expect smooth transitions
/// - **Perfect for UI**: Excellent for buttons, cards, and backgrounds
/// - **Mathematical elegance**: Based on proven computer graphics techniques
///
/// ## Comparison with Other Gradients
///
/// ```swift
/// VStack(spacing: 20) {
///     // Standard linear gradient - constant rate of change
///     LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
///         .frame(height: 60)
///     
///     // Exponential gradient - power function curve
///     ExponentialGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
///         .frame(height: 60)
///     
///     // Smooth gradient - zero derivatives at endpoints
///     SmoothGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
///         .frame(height: 60)
/// }
/// ```
///
/// ## Usage Examples
///
/// ```swift
/// // Simple button background
/// Button("Tap me") {
///     // action
/// }
/// .background {
///     SmoothGradient(
///         colors: [.blue, .purple],
///         startPoint: .topLeading,
///         endPoint: .bottomTrailing
///     )
///     .cornerRadius(12)
/// }
///
/// // Card with subtle gradient
/// VStack {
///     Text("Beautiful Card")
///     Text("With smooth gradient")
/// }
/// .padding()
/// .background {
///     SmoothGradient(
///         colors: [.white, .gray.opacity(0.05)],
///         startPoint: .top,
///         endPoint: .bottom,
///         smoothType: .smootherstep
///     )
/// }
/// .cornerRadius(16)
/// .shadow(radius: 2)
/// ```
@available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)
public struct SmoothGradient: View, Sendable {
    public let gradient: Gradient
    public let startPoint: UnitPoint
    public let endPoint: UnitPoint
    public let smoothType: SmoothStepType
    public let subdivisions: Int

    /// Creates a smooth gradient with the specified parameters.
    ///
    /// - Parameters:
    ///   - gradient: The gradient containing the colors and their locations.
    ///   - startPoint: The point at which the gradient begins.
    ///   - endPoint: The point at which the gradient ends.
    ///   - smoothType: The type of smoothstep function to use. Default is `.smootherstep`.
    ///   - subdivisions: The number of steps to use when interpolating between colors. Higher values create smoother transitions. Default is 32.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Create a custom gradient with specific color stops
    /// let customGradient = Gradient(stops: [
    ///     .init(color: .blue, location: 0.0),
    ///     .init(color: .green, location: 0.3),
    ///     .init(color: .red, location: 1.0)
    /// ])
    ///
    /// // Use the custom gradient with SmoothGradient
    /// SmoothGradient(
    ///     gradient: customGradient,
    ///     startPoint: .topLeading,
    ///     endPoint: .bottomTrailing,
    ///     smoothType: .smootherstep,
    ///     subdivisions: 64
    /// )
    /// ```
    public init(
        gradient: Gradient,
        startPoint: UnitPoint,
        endPoint: UnitPoint,
        smoothType: SmoothStepType = .smootherstep,
        subdivisions: Int = 32
    ) {
        self.gradient = gradient
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.smoothType = smoothType
        self.subdivisions = subdivisions
    }

    /// Creates a smooth gradient with the specified colors.
    ///
    /// - Parameters:
    ///   - colors: An array of colors to use in the gradient, evenly distributed from start to end.
    ///   - startPoint: The point at which the gradient begins.
    ///   - endPoint: The point at which the gradient ends.
    ///   - smoothType: The type of smoothstep function to use. Default is `.smootherstep`.
    ///   - subdivisions: The number of steps to use when interpolating between colors. Higher values create smoother transitions. Default is 32.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Create a beautiful background gradient
    /// ZStack {
    ///     SmoothGradient(
    ///         colors: [.indigo, .purple, .pink],
    ///         startPoint: .top,
    ///         endPoint: .bottom,
    ///         smoothType: .smootherstep
    ///     )
    ///
    ///     Text("Hello, World!")
    ///         .font(.largeTitle)
    ///         .foregroundStyle(.white)
    /// }
    /// ```
    public init(
        colors: [Color],
        startPoint: UnitPoint,
        endPoint: UnitPoint,
        smoothType: SmoothStepType = .smootherstep,
        subdivisions: Int = 32
    ) {
        self.init(
            gradient: Gradient(colors: colors),
            startPoint: startPoint,
            endPoint: endPoint,
            smoothType: smoothType,
            subdivisions: subdivisions
        )
    }

    /// Creates a smooth gradient with the specified color stops.
    ///
    /// - Parameters:
    ///   - stops: An array of gradient stops, each containing a color and location.
    ///   - startPoint: The point at which the gradient begins.
    ///   - endPoint: The point at which the gradient ends.
    ///   - smoothType: The type of smoothstep function to use. Default is `.smootherstep`.
    ///   - subdivisions: The number of steps to use when interpolating between colors. Higher values create smoother transitions. Default is 32.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Create a gradient with precise color positioning for a glass effect
    /// SmoothGradient(
    ///     stops: [
    ///         .init(color: .clear, location: 0.0),
    ///         .init(color: .white.opacity(0.1), location: 0.1),
    ///         .init(color: .white.opacity(0.3), location: 0.5),
    ///         .init(color: .white.opacity(0.1), location: 0.9),
    ///         .init(color: .clear, location: 1.0)
    ///     ],
    ///     startPoint: .top,
    ///     endPoint: .bottom,
    ///     smoothType: .smootherstep
    /// )
    /// .frame(height: 200)
    /// .background(.ultraThinMaterial)
    /// .clipShape(RoundedRectangle(cornerRadius: 20))
    /// ```
    public init(
        stops: [Gradient.Stop],
        startPoint: UnitPoint,
        endPoint: UnitPoint,
        smoothType: SmoothStepType = .smootherstep,
        subdivisions: Int = 32
    ) {
        self.init(
            gradient: Gradient(stops: stops),
            startPoint: startPoint,
            endPoint: endPoint,
            smoothType: smoothType,
            subdivisions: subdivisions
        )
    }

    public var body: some View {
        LinearGradient(
            stops: subdividedStops,
            startPoint: startPoint,
            endPoint: endPoint
        )
    }

    @available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)
    private var subdividedStops: [Gradient.Stop] {
        guard gradient.stops.count > 1 else { return gradient.stops }
        var result: [Gradient.Stop] = []
        
        for i in 0..<(gradient.stops.count - 1) {
            let current = gradient.stops[i]
            let next = gradient.stops[i + 1]
            
            for step in 0..<subdivisions {
                let linearFraction = CGFloat(step) / CGFloat(subdivisions)
                let smoothFraction = smoothType.apply(to: linearFraction)
                let location = current.location + (next.location - current.location) * linearFraction
                let color = current.color.smoothInterpolated(
                    to: next.color,
                    fraction: smoothFraction
                )
                result.append(.init(color: color, location: Double(location)))
            }
        }
        result.append(gradient.stops.last!)
        return result
    }
}

extension Color {
    @available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)
    func smoothInterpolated(to other: Color, fraction: CGFloat) -> Color {
        let c1 = toComponents()
        let c2 = other.toComponents()
        let r = c1.r + (c2.r - c1.r) * fraction
        let g = c1.g + (c2.g - c1.g) * fraction
        let b = c1.b + (c2.b - c1.b) * fraction
        let a = c1.a + (c2.a - c1.a) * fraction
        #if canImport(UIKit)
        return Color(UIColor(red: r, green: g, blue: b, alpha: a))
        #else
        return self
        #endif
    }
}
