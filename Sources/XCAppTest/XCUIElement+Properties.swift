import XCTest

extension XCUIElement {

    /// The raw value attribute of the element cast to `String`.
    public var stringValue: String? {
        value as? String
    }
    
    /// The raw value attribute of the element cast to `Int`.
    public var intValue: Int? {
        value as? Int
    }

    /// The on state of the element.
    public var isOn: Bool {
        return stringValue == "1" || intValue == 1
    }
}
