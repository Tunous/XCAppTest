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
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertExists(
        waitForAppToIdle: Bool = false,
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        XCTContext.runActivity(named: "Assert \(self) exists") { _ in
            if !exists || waitForAppToIdle {
                XCTAssertTrue(
                    waitForExistence(timeout: timeout),
                    message() ?? "\(self) should be visible",
                    file: file,
                    line: line
                )
            }
        }
        return self
    }

    /// Asserts that the current UI element does not exist.
    ///
    /// - Parameters:
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertNotExists(
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) NOT exists",
            condition: { !$0.exists },
            timeout: timeout,
            message() ?? "\(self) should NOT exist",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element existence matches `exists` parameter.
    ///
    /// - Parameters:
    ///   - exists: Whether the element should exist or not.
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertExists(
        _ exists: Bool,
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) \(exists ? "exists" : "NOT exists")",
            condition: { $0.exists == exists },
            timeout: timeout,
            message() ?? "\(self) should \(exists ? "exist" : "NOT exist")",
            file: file,
            line: line
        )
        return self
    }

    // MARK: - Checking interactivity

    /// Asserts that the current UI element is hittable.
    ///
    /// - Parameters:
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsHittable(
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) is hittable",
            condition: { $0.isHittable },
            timeout: timeout,
            message() ?? "\(self) should be hittable",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element is not hittable.
    ///
    /// - Parameters:
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsNotHittable(
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) is not hittable",
            condition: { !$0.isHittable },
            timeout: timeout,
            message() ?? "\(self) should NOT be hittable",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element's hittable state matches `isHittable` parameter.
    ///
    /// - Parameters:
    ///   - isHittable: Whether the element should be hittable or not.
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsHittable(
        _ isHittable: Bool,
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        if isHittable {
            return assertIsHittable(timeout: timeout, message(), file: file, line: line)
        }
        return assertIsNotHittable(timeout: timeout, message(), file: file, line: line)
    }

    /// Asserts that the current UI element is enabled.
    ///
    /// - Parameters:
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsEnabled(
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) is enabled",
            condition: { $0.isEnabled },
            timeout: timeout,
            message() ?? "\(self) should be enabled",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element is disabled.
    ///
    /// - Parameters:
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsDisabled(
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) is NOT enabled",
            condition: { !$0.isEnabled },
            timeout: timeout,
            message() ?? "\(self) should NOT be enabled",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element's enabled state matches `isEnabled` parameter.
    ///
    /// - Parameters:
    ///   - isEnabled: Whether the element should be enabled or not.
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsEnabled(
        _ isEnabled: Bool,
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        if isEnabled {
            return assertIsEnabled(timeout: timeout, message(), file: file, line: line)
        }
        return assertIsDisabled(timeout: timeout, message(), file: file, line: line)
    }

    /// Asserts that the current UI element exists, is hittable and enabled.
    ///
    /// - Parameters:
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsInteractive(
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) is interactive",
            condition: { $0.exists && $0.isEnabled && $0.isHittable },
            timeout: timeout,
            message() ?? "\(self) should be enabled and hittable",
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
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertHasLabel(
        _ label: String,
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) has label '\(label)'",
            condition: { $0.label == label },
            timeout: timeout,
            message() ?? "\(self) has incorrect label. Expected: '\(label)' but found: '\(self.label)'",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element's `label` contains given `text`.
    ///
    /// - Parameters:
    ///   - text: The text that should be contained inside of element's `label`.
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertContainsText(
        _ text: String,
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) label contains text '\(text)'",
            condition: { $0.label.contains(text) },
            timeout: timeout,
            message() ?? "\(self) doesn't contain substring '\(text)' in its label: '\(self.label)'",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element's raw attribute value is equal to `expectedValue`.
    ///
    /// - Parameters:
    ///   - expectedValue: The expected value attribute of the element.
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertHasValue<T: Equatable>(
        _ expectedValue: T,
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) has value '\(expectedValue)'",
            condition: { $0.value as? T == expectedValue },
            timeout: timeout,
            message() ?? "\(self) has incorrect value. Expected '\(expectedValue)' but found '\(self.value ?? "")'",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element's raw attribute value corresponds to given on/off state.
    ///
    /// - Parameters:
    ///   - isOn: The expected on/off state of the element.
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsOn(
        _ isOn: Bool = true,
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        return assertHasValue(isOn ? "1" : "0", timeout: timeout, message(), file: file, line: line)
    }

    /// Asserts that the current UI element's raw attribute value corresponds to off state.
    ///
    /// - Parameters:
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsOff(
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        return assertIsOn(false, timeout: timeout, message(), file: file, line: line)
    }

    /// Asserts that the current UI element has placeholder value equal to `expectedPlaceholder`.
    ///
    /// - Parameters:
    ///   - expectedPlaceholder: The expected placeholder value of the element.
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertHasPlaceholder(
        _ expectedPlaceholder: String?,
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) has placeholder '\(String(describing: expectedPlaceholder))'",
            condition: { $0.placeholderValue == expectedPlaceholder },
            timeout: timeout,
            message() ?? "\(self) has incorrect placeholder value. Expected '\(String(describing: expectedPlaceholder))' but found '\(String(describing: self.value))'",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element has its value equal to its placeholder.
    ///
    /// - Parameters:
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsEmpty(
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) is empty",
            condition: { $0.stringValue == $0.placeholderValue },
            timeout: timeout,
            message() ?? "\(self) is not empty. Expected value '\(String(describing: self.value))' to be equal to placeholder value '\(String(describing: self.placeholderValue))'",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element has title equal to given value.
    ///
    /// - Parameters:
    ///   - title: The expected title attribute of the element.
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertHasTitle(
        _ title: String,
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) has title '\(title)'",
            condition: { $0.title == title },
            timeout: timeout,
            message() ?? "\(self) has incorrect title. Expected: '\(title)' but found: '\(self.title)'",
            file: file,
            line: line
        )
        return self
    }

    // MARK: - Checking traits

    /// Asserts that the current UI element is selected.
    ///
    /// - Parameters:
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsSelected(
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) is selected",
            condition: { $0.isSelected },
            timeout: timeout,
            message() ?? "\(self) should be selected",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element is not selected.
    ///
    /// - Parameters:
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsNotSelected(
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) is NOT selected",
            condition: { !$0.isSelected },
            timeout: timeout,
            message() ?? "\(self) should NOT be selected",
            file: file,
            line: line
        )
        return self
    }

    /// Asserts that the current UI element's selected state matches `isSelected` parameter.
    ///
    /// - Parameters:
    ///   - isSelected: Whether the element should be selected or not.
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func assertIsSelected(
        _ isSelected: Bool,
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        if isSelected {
            return assertIsSelected(timeout: timeout, message(), file: file, line: line)
        }
        return assertIsNotSelected(timeout: timeout, message(), file: file, line: line)
    }
}
