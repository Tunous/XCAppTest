import XCTest

extension XCUIElement {

    // MARK: - Checking existence

    /// Asserts that the current UI element exists.
    ///
    /// If the element exists at the time of call, this function will return immediately. If you need to make sure that the app becomes
    /// idle before performing the check pass `waitForAppToIdle` parameter as `true`.
    ///
    /// - Parameters:
    ///   - waitForAppToIdle: If `true` will use `waitForExistence` method to make sure that the app is idle before passing.
    ///     Defaults to false.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertExists(
        waitForAppToIdle: Bool = false,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        if exists && !waitForAppToIdle { return self }
        XCTAssertTrue(waitForExistence(timeout: 8), message() ?? "Element should be visible", file: file, line: line)
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
        assert(
            condition: { !$0.exists },
            message() ?? "Element should NOT exist",
            file: file,
            line: line
        )
        return self
    }

    // MARK: - Checking interactivity

    /// Asserts that the current UI element is hittable.
    ///
    /// - Parameters:
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsHittable(
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            condition: { $0.isHittable },
            message() ?? "Element should be hittable",
            file: file,
            line: line
        )
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
        assert(
            condition: { !$0.isHittable },
            message() ?? "Element should NOT be hittable",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element is enabled.
    ///
    /// - Parameters:
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsEnabled(
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            condition: { $0.isEnabled },
            message() ?? "Element should be enabled",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element is disabled.
    ///
    /// - Parameters:
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsDisabled(
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            condition: { !$0.isEnabled },
            message() ?? "Element should NOT be enabled",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element exists, is hittable and enabled.
    ///
    /// - Parameters:
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsInteractive(
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            condition: { $0.exists && $0.isEnabled && $0.isHittable },
            message() ?? "Element should be enabled and hittable",
            file: file,
            line: line
        )
        return self
    }

    // MARK: - Checking properties

    /// Asserts that the current UI element has label equal to given value.
    ///
    /// - Parameters:
    ///   - label: The expected label attribute of the element.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertHasLabel(
        _ label: String,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            condition: { $0.label == label },
            message() ?? "Element has incorrect label. Expected: '\(label)' but found: '\(self.label)'",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element's `label` contains given `text`.
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
        assert(
            condition: { $0.label.contains(text) },
            message() ?? "Element doesn't contain substring '\(text)' in its label: '\(self.label)'",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element raw attribute value equal to `expectedValue`.
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
        assert(
            condition: { $0.value as? T == expectedValue },
            message() ?? "Element has incorrect value. Expected '\(expectedValue)' but found '\(self.value ?? "")'",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element has placeholder value equal to `expectedPlaceholder`.
    ///
    /// - Parameters:
    ///   - expectedPlaceholder: The expected placeholder value of the element.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertHasPlaceholder(
        _ expectedPlaceholder: String?,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            condition: { $0.placeholderValue == expectedPlaceholder },
            message() ?? "Element has incorrect placeholder value. Expected '\(String(describing: expectedPlaceholder))' but found '\(String(describing: self.value))'",
            file: file,
            line: line
        )
        return self
    }

    // MARK: - Checking traits

    /// Asserts that the current UI element is selected.
    ///
    /// - Parameters:
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsSelected(
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            condition: { $0.isSelected },
            message() ?? "Element should be selected",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element is not selected.
    ///
    /// - Parameters:
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsNotSelected(
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            condition: { !$0.isSelected },
            message() ?? "Element should NOT be selected",
            file: file,
            line: line
        )
        return self
    }

    // MARK: - Waiting for interactivity

    /// Waits for the element to exist, be hittable and enabled.
    ///
    /// - Parameters:
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func waitForInteractivity(
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assertExists(waitForAppToIdle: true, message() ?? "Element should exist to be interactive.", file: file, line: line)
        assertIsInteractive(message(), file: file, line: line)
        return self
    }
}
