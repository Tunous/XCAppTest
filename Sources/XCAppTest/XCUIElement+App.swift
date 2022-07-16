import XCTest

extension XCUIElement {

    // MARK: - Assertions

    /// Asserts that the current UI element exists and has label equal to given value.
    ///
    /// - Parameters:
    ///   - label: The expected label attribute of the element.
    ///   - wait: <#wait description#>
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertHasLabel(
        _ label: String,
        wait: Bool = false,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assertExists(wait: wait, file: file, line: line)
        XCTAssertEqual(self.label, label, message() ?? "Element \(self) has incorrect label", file: file, line: line)
        return self
    }

    /// Asserts that the current UI element exists and its `label` contains given `text`.
    ///
    /// - Parameters:
    ///   - text: The text that should be contained inside of element's `label`.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertContainsText(
        _ text: String,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assertExists(message(), file: file, line: line)
        XCTAssertTrue(label.contains(text), message() ?? "Element \(self) doesn't contain substring '\(text)' in its label", file: file, line: line)
        return self
    }

    /// Asserts that the current UI element exists and has raw attribute value equal to `expectedValue`.
    ///
    /// - Parameters:
    ///   - expectedValue: The expected value attribute of the element.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertHasValue<T: Equatable>(
        _ expectedValue: T,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assertExists(file: file, line: line)
        XCTAssertEqual(value as? T, expectedValue, message() ?? "Element \(self) has incorrect value", file: file, line: line)
        return self
    }

    /// Asserts that the current UI element is hittable and enabled.
    ///
    /// - Parameters:
    ///   - wait: <#wait description#>
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsInteractive(
        wait: Bool = false,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assertIsHittable(wait: true, message(), file: file, line: line)
        XCTAssertTrue(isEnabled, message() ?? "Element \(self) should be enabled", file: file, line: line)
        return self
    }

    /// Asserts that the current UI element exists but is disabled.
    ///
    /// - Parameters:
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsNotInteractive(
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assertExists(message(), file: file, line: line)
        XCTAssertFalse(isEnabled, message() ?? "Element \(self) should NOT be enabled", file: file, line: line)
        return self
    }

    /// Asserts that the current UI element exists.
    ///
    /// - Parameters:
    ///   - wait: <#wait description#>
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertExists(
        wait: Bool = false,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        if exists && !wait { return self }
        XCTAssertTrue(waitForExistence(timeout: 5), message() ?? "Element \(self) should be visible", file: file, line: line)
        return self
    }

    /// Asserts that the current UI element does not exist.
    ///
    /// - Parameters:
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertNotExists(
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        if !exists { return self }
        assertPredicate("\(#keyPath(XCUIElement.exists)) == FALSE", message: message() ?? "Element \(self) should NOT exist", file: file, line: line)
        return self
    }

    /// Asserts that the current UI element is hittable.
    ///
    /// - Parameters:
    ///   - wait: <#wait description#>
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsHittable(
        wait: Bool = false,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        if isHittable && !wait { return self }
        assertPredicate("\(#keyPath(XCUIElement.isHittable)) == TRUE", message: message() ?? "Element \(self) should be hittable", file: file, line: line)
        return self
    }

    /// Asserts that the current UI element is not hittable.
    ///
    /// - Parameters:
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsNotHittable(
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        if !isHittable { return self }
        assertPredicate("\(#keyPath(XCUIElement.isHittable)) == FALSE", message: message() ?? "Element \(self) should NOT be hittable", file: file, line: line)
        return self
    }
}

extension XCUIElement {

    // MARK: - Actions

    /// Waits until the current UI element is hittable and enabled and then taps on it.
    ///
    /// - Parameters:
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func waitForInteractivityAndTap(
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assertIsInteractive(wait: true, message(), file: file, line: line)
        tap()
        return self
    }
}

extension XCUIElement {
    private func assertPredicate(
        _ predicateFormat: String,
        message: @autoclosure () -> String,
        file: StaticString,
        line: UInt
    ) {
        let predicate = NSPredicate(format: predicateFormat)
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertTrue(result == .completed, message(), file: file, line: line)
    }
}
