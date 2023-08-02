import Foundation

extension CGVector {

    /// Normalized offset to view's top left coordinate.
    public static let topLeft: CGVector = CGVector(dx: 0, dy: 0)

    /// Normalized offset to view's top center coordinate.
    public static let top: CGVector = CGVector(dx: 0.5, dy: 0)

    /// Normalized offset to view's top right coordinate.
    public static let topRight: CGVector = CGVector(dx: 1, dy: 0)

    /// Normalized offset to view's center left coordinate.
    public static let left: CGVector = CGVector(dx: 0, dy: 0.5)

    /// Normalized offset to view's center coordinate.
    public static let center: CGVector = CGVector(dx: 0.5, dy: 0.5)

    /// Normalized offset to view's center right coordinate.
    public static let right: CGVector = CGVector(dx: 1, dy: 0.5)

    /// Normalized offset to view's bottom left coordinate.
    public static let bottomLeft: CGVector = CGVector(dx: 0, dy: 1)

    /// Normalized offset to view's bottom center coordinate.
    public static let bottom: CGVector = CGVector(dx: 0.5, dy: 1)

    /// Normalized offset to view's bottom right coordinate.
    public static let bottomRight: CGVector = CGVector(dx: 1, dy: 1)
    
    /// Vector with x and y components offset by given values.
    ///
    /// - Parameters:
    ///   - x: Offset to apply to x component.
    ///   - y: Offset to apply to y component.
    /// - Returns: Vector with offset x and y components.
    public func offset(x: CGFloat = 0, y: CGFloat = 0) -> CGVector {
        return CGVector(dx: dx + x, dy: dy + y)
    }
}
