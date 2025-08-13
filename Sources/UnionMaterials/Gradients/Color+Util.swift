//
//  Color+Util.swift
//  union-gradients
//
//  Created by Ben Sage on 4/9/25.
//

import SwiftUI

extension Color {
    /// Converts a SwiftUI Color to its RGBA components.
    ///
    /// - Returns: A tuple containing the red, green, blue, and alpha components, each in the range 0-1.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let color = Color.red
    /// let components = color.toComponents()
    /// print("R: \(components.r), G: \(components.g), B: \(components.b), A: \(components.a)")
    /// // Output: "R: 1.0, G: 0.0, B: 0.0, A: 1.0"
    /// ```
    @available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)
    func toComponents() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        #if canImport(UIKit)
        let c = UIColor(self).cgColor
        guard let comps = c.components else { return (0, 0, 0, 1) }
        if comps.count < 4 { return (comps[0], comps[0], comps[0], comps.count > 1 ? comps[1] : 1) }
        return (comps[0], comps[1], comps[2], comps[3])
        #else
        return (0, 0, 0, 1)
        #endif
    }

    /// Interpolates between this color and another using an exponential function.
    ///
    /// - Parameters:
    ///   - other: The target color to interpolate toward.
    ///   - fraction: A value from 0 to 1 representing the linear distance between the colors.
    ///   - exponent: The power to which the fraction is raised, creating a non-linear interpolation.
    /// - Returns: A new color that represents the exponentially interpolated result.
    ///
    /// ## Example
    ///
    /// ```swift
    /// // Create a transition between blue and green with an exponential curve
    /// let startColor = Color.blue
    /// let endColor = Color.green
    ///
    /// // Linear midpoint (0.5) with exponent 2.0 results in a color closer to blue
    /// let midpointColor = startColor.interpolated(to: endColor, fraction: 0.5, exponent: 2.0)
    ///
    /// HStack {
    ///     Rectangle().fill(startColor)
    ///     Rectangle().fill(midpointColor)  // Will be closer to blue than green
    ///     Rectangle().fill(endColor)
    /// }
    /// ```
    @available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)
    func interpolated(to other: Color, fraction: CGFloat, exponent: CGFloat) -> Color {
        let f = pow(fraction, exponent)
        let c1 = toComponents()
        let c2 = other.toComponents()
        let r = c1.r + (c2.r - c1.r) * f
        let g = c1.g + (c2.g - c1.g) * f
        let b = c1.b + (c2.b - c1.b) * f
        let a = c1.a + (c2.a - c1.a) * f
        #if canImport(UIKit)
        return Color(UIColor(red: r, green: g, blue: b, alpha: a))
        #else
        return self
        #endif
    }
}
