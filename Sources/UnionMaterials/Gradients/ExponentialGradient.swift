//
//  ExponentialGradient.swift
//  union-gradients
//
//  Created by Ben Sage on 4/9/25.
//

import SwiftUI

/// A gradient that applies an exponential function to color interpolation, creating more natural-looking transitions.
///
/// Unlike standard linear gradients that use constant rate of change between colors, `ExponentialGradient`
/// uses a power function to create non-linear transitions that can better mimic how light behaves in physical space.
///
/// ## Example
///
/// ```swift
/// VStack(spacing: 30) {
///     // Standard linear gradient
///     LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
///         .frame(height: 100)
///         .cornerRadius(10)
///
///     // Exponential gradient for more natural transition
///     ExponentialGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
///         .frame(height: 100)
///         .cornerRadius(10)
/// }
/// .padding()
/// ```
@available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)
public struct ExponentialGradient: View, Sendable {
    public let gradient: Gradient
    public let startPoint: UnitPoint
    public let endPoint: UnitPoint
    public let exponent: CGFloat
    public let subdivisions: Int

    /// Creates an exponential gradient with the specified parameters.
    ///
    /// - Parameters:
    ///   - gradient: The gradient containing the colors and their locations.
    ///   - startPoint: The point at which the gradient begins.
    ///   - endPoint: The point at which the gradient ends.
    ///   - exponent: The power to which the interpolation is raised. Values greater than 1 create a slower start and faster finish.
    ///                Values less than 1 create a faster start and slower finish. Default is 2.
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
    /// // Use the custom gradient with ExponentialGradient
    /// ExponentialGradient(
    ///     gradient: customGradient,
    ///     startPoint: .topLeading,
    ///     endPoint: .bottomTrailing,
    ///     exponent: 2.5,
    ///     subdivisions: 64
    /// )
    /// ```
    public init(
        gradient: Gradient,
        startPoint: UnitPoint,
        endPoint: UnitPoint,
        exponent: CGFloat = 2,
        subdivisions: Int = 32
    ) {
        self.gradient = gradient
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.exponent = exponent
        self.subdivisions = subdivisions
    }

    /// Creates an exponential gradient with the specified colors.
    ///
    /// - Parameters:
    ///   - colors: An array of colors to use in the gradient, evenly distributed from start to end.
    ///   - startPoint: The point at which the gradient begins.
    ///   - endPoint: The point at which the gradient ends.
    ///   - exponent: The power to which the interpolation is raised. Values greater than 1 create a slower start and faster finish.
    ///                Values less than 1 create a faster start and slower finish. Default is 2.
    ///   - subdivisions: The number of steps to use when interpolating between colors. Higher values create smoother transitions. Default is 32.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Create a background with an exponential gradient
    /// ZStack {
    ///     ExponentialGradient(
    ///         colors: [.indigo, .purple, .pink],
    ///         startPoint: .top,
    ///         endPoint: .bottom,
    ///         exponent: 3.0
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
        exponent: CGFloat = 2,
        subdivisions: Int = 32
    ) {
        self.init(
            gradient: Gradient(colors: colors),
            startPoint: startPoint,
            endPoint: endPoint,
            exponent: exponent,
            subdivisions: subdivisions
        )
    }

    /// Creates an exponential gradient with the specified color stops.
    ///
    /// - Parameters:
    ///   - stops: An array of gradient stops, each containing a color and location.
    ///   - startPoint: The point at which the gradient begins.
    ///   - endPoint: The point at which the gradient ends.
    ///   - exponent: The power to which the interpolation is raised. Values greater than 1 create a slower start and faster finish.
    ///                Values less than 1 create a faster start and slower finish. Default is 2.
    ///   - subdivisions: The number of steps to use when interpolating between colors. Higher values create smoother transitions. Default is 32.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Create a gradient with precise color positioning
    /// ExponentialGradient(
    ///     stops: [
    ///         .init(color: .clear, location: 0.0),
    ///         .init(color: .blue.opacity(0.5), location: 0.3),
    ///         .init(color: .blue, location: 0.7),
    ///         .init(color: .purple, location: 1.0)
    ///     ],
    ///     startPoint: .leading,
    ///     endPoint: .trailing,
    ///     exponent: 1.5,
    ///     subdivisions: 48
    /// )
    /// .frame(height: 150)
    /// .clipShape(RoundedRectangle(cornerRadius: 20))
    /// ```
    public init(
        stops: [Gradient.Stop],
        startPoint: UnitPoint,
        endPoint: UnitPoint,
        exponent: CGFloat = 2,
        subdivisions: Int = 32
    ) {
        self.init(
            gradient: Gradient(stops: stops),
            startPoint: startPoint,
            endPoint: endPoint,
            exponent: exponent,
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
                let fraction = CGFloat(step) / CGFloat(subdivisions)
                let location = current.location + (next.location - current.location) * fraction
                let color = current.color.interpolated(
                    to: next.color,
                    fraction: fraction,
                    exponent: exponent
                )
                result.append(.init(color: color, location: Double(location)))
            }
        }
        result.append(gradient.stops.last!)
        return result
    }
}
