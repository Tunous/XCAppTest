import XCTest

extension XCUIElement {

    /// The raw value attribute of the element cast to `String`.
    public var stringValue: String? {
        value as? String
    }
}
