//
//  MathFunctions.swift
//  union-gradients
//
//  Created by Ben Sage on 4/9/25.
//

import Foundation

/// A collection of mathematical interpolation functions for creating custom gradient behaviors.
///
/// These functions provide various easing and interpolation curves that can be used to create
/// custom gradient effects or animations. All functions map input range [0, 1] to output range [0, 1].
///
/// ## Usage
///
/// ```swift
/// // Use these functions to create custom gradient behaviors
/// let t: CGFloat = 0.5
/// let smoothResult = MathFunctions.smootherstep(t)  // ≈ 0.5
/// let easeResult = MathFunctions.easeInOut(t)       // = 0.5
/// let sineResult = MathFunctions.sine(t)            // ≈ 0.707
/// ```
public struct MathFunctions {
    
    /// Classic smoothstep function: f(t) = 3t² - 2t³
    ///
    /// Provides smooth interpolation with zero first derivatives at both endpoints.
    /// Creates an S-shaped curve that starts slowly, accelerates in the middle, then slows down.
    ///
    /// - Parameter t: Input value, automatically clamped to [0, 1]
    /// - Returns: Smoothly interpolated value in range [0, 1]
    ///
    /// ## Mathematical Properties
    /// - f(0) = 0, f(1) = 1
    /// - f'(0) = 0, f'(1) = 0 (zero derivatives at endpoints)
    /// - Inflection point at t = 0.5
    ///
    /// ## Example
    /// ```swift
    /// let result = MathFunctions.smoothstep(0.5)  // ≈ 0.5
    /// let start = MathFunctions.smoothstep(0.0)   // = 0.0
    /// let end = MathFunctions.smoothstep(1.0)     // = 1.0
    /// ```
    public static func smoothstep(_ t: CGFloat) -> CGFloat {
        let clamped = max(0, min(1, t))
        return 3 * clamped * clamped - 2 * clamped * clamped * clamped
    }
    
    /// Enhanced smootherstep function: f(t) = 6t⁵ - 15t⁴ + 10t³
    ///
    /// Provides even smoother interpolation with zero first and second derivatives at endpoints.
    /// Creates a more pronounced S-shaped curve than smoothstep.
    ///
    /// - Parameter t: Input value, automatically clamped to [0, 1]
    /// - Returns: Smoothly interpolated value in range [0, 1]
    ///
    /// ## Mathematical Properties
    /// - f(0) = 0, f(1) = 1
    /// - f'(0) = 0, f'(1) = 0, f''(0) = 0, f''(1) = 0
    /// - Even smoother transitions than smoothstep
    ///
    /// ## Example
    /// ```swift
    /// let result = MathFunctions.smootherstep(0.5)  // ≈ 0.5
    /// // Compare with smoothstep for subtle differences
    /// let smooth = MathFunctions.smoothstep(0.3)     // ≈ 0.216
    /// let smoother = MathFunctions.smootherstep(0.3) // ≈ 0.163
    /// ```
    public static func smootherstep(_ t: CGFloat) -> CGFloat {
        let clamped = max(0, min(1, t))
        let t3 = clamped * clamped * clamped
        let t4 = t3 * clamped
        let t5 = t4 * clamped
        return 6 * t5 - 15 * t4 + 10 * t3
    }
    
    /// Maximum smoothness smootheststep function: f(t) = -20t⁷ + 70t⁶ - 84t⁵ + 35t⁴
    ///
    /// Provides the smoothest possible interpolation with zero first, second, and third derivatives.
    /// Creates the most gradual S-shaped curve of all smoothstep variants.
    ///
    /// - Parameter t: Input value, automatically clamped to [0, 1]
    /// - Returns: Smoothly interpolated value in range [0, 1]
    ///
    /// ## Mathematical Properties
    /// - f(0) = 0, f(1) = 1
    /// - f'(0) = 0, f'(1) = 0, f''(0) = 0, f''(1) = 0, f'''(0) = 0, f'''(1) = 0
    /// - Maximum mathematical smoothness
    ///
    /// ## Example
    /// ```swift
    /// let result = MathFunctions.smootheststep(0.5)  // ≈ 0.5
    /// // Extremely gradual transitions near endpoints
    /// let nearStart = MathFunctions.smootheststep(0.1)  // ≈ 0.00856
    /// ```
    public static func smootheststep(_ t: CGFloat) -> CGFloat {
        let clamped = max(0, min(1, t))
        let t3 = clamped * clamped * clamped
        let t4 = t3 * clamped
        let t5 = t4 * clamped
        let t6 = t5 * clamped
        let t7 = t6 * clamped
        return -20 * t7 + 70 * t6 - 84 * t5 + 35 * t4
    }
    
    /// Quadratic ease-in-out function.
    ///
    /// Accelerates from zero velocity at the start, then decelerates to zero velocity at the end.
    /// Creates a symmetric curve with faster transitions than smoothstep.
    ///
    /// - Parameter t: Input value, automatically clamped to [0, 1]
    /// - Returns: Eased value in range [0, 1]
    ///
    /// ## Mathematical Properties
    /// - f(0) = 0, f(1) = 1
    /// - Symmetric around t = 0.5
    /// - Sharper curve than smoothstep functions
    ///
    /// ## Example
    /// ```swift
    /// let result = MathFunctions.easeInOut(0.5)    // = 0.5
    /// let quarter = MathFunctions.easeInOut(0.25)  // = 0.125
    /// let threeFourths = MathFunctions.easeInOut(0.75)  // = 0.875
    /// ```
    public static func easeInOut(_ t: CGFloat) -> CGFloat {
        let clamped = max(0, min(1, t))
        return clamped < 0.5 
            ? 2 * clamped * clamped 
            : 1 - 2 * (1 - clamped) * (1 - clamped)
    }
    
    /// Cubic ease-in-out function.
    ///
    /// Similar to easeInOut but with cubic curves for even more pronounced acceleration/deceleration.
    /// Creates more dramatic ease-in and ease-out transitions.
    ///
    /// - Parameter t: Input value, automatically clamped to [0, 1]
    /// - Returns: Eased value in range [0, 1]
    ///
    /// ## Mathematical Properties
    /// - f(0) = 0, f(1) = 1
    /// - Symmetric around t = 0.5
    /// - More pronounced curve than quadratic ease-in-out
    ///
    /// ## Example
    /// ```swift
    /// let result = MathFunctions.easeInOutCubic(0.5)    // = 0.5
    /// let quarter = MathFunctions.easeInOutCubic(0.25)  // = 0.0625
    /// let threeFourths = MathFunctions.easeInOutCubic(0.75)  // = 0.9375
    /// ```
    public static func easeInOutCubic(_ t: CGFloat) -> CGFloat {
        let clamped = max(0, min(1, t))
        return clamped < 0.5 
            ? 4 * clamped * clamped * clamped 
            : 1 - pow(-2 * clamped + 2, 3) / 2
    }
    
    /// Sine-based easing function.
    ///
    /// Uses a quarter sine wave to create smooth acceleration from zero velocity.
    /// Provides a gentler curve than quadratic functions.
    ///
    /// - Parameter t: Input value, automatically clamped to [0, 1]
    /// - Returns: Sine-eased value in range [0, 1]
    ///
    /// ## Mathematical Properties
    /// - f(0) = 0, f(1) = 1
    /// - f'(0) = π/2 ≈ 1.57 (starts with some velocity)
    /// - f'(1) = 0 (ends with zero velocity)
    ///
    /// ## Example
    /// ```swift
    /// let result = MathFunctions.sine(0.5)  // ≈ 0.707
    /// let quarter = MathFunctions.sine(0.25)  // ≈ 0.383
    /// ```
    public static func sine(_ t: CGFloat) -> CGFloat {
        let clamped = max(0, min(1, t))
        return sin(clamped * .pi / 2)
    }
    
    /// Cosine-based easing function.
    ///
    /// Uses a quarter cosine wave to create smooth deceleration to zero velocity.
    /// Complementary to the sine function.
    ///
    /// - Parameter t: Input value, automatically clamped to [0, 1]
    /// - Returns: Cosine-eased value in range [0, 1]
    ///
    /// ## Mathematical Properties
    /// - f(0) = 0, f(1) = 1
    /// - f'(0) = 0 (starts with zero velocity)
    /// - f'(1) = π/2 ≈ 1.57 (ends with some velocity)
    ///
    /// ## Example
    /// ```swift
    /// let result = MathFunctions.cosine(0.5)  // ≈ 0.293
    /// let quarter = MathFunctions.cosine(0.75)  // ≈ 0.617
    /// ```
    public static func cosine(_ t: CGFloat) -> CGFloat {
        let clamped = max(0, min(1, t))
        return 1 - cos(clamped * .pi / 2)
    }
}
