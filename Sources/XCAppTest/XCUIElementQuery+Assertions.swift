import XCTest

extension XCUIElementQuery {

    // MARK: - Checking number of elements

    /// Evaluates the query and asserts that it matches `count` number of elements.
    ///
    /// - Parameters:
    ///   - count: The expected number of elements that should match the query.
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element query.
    @discardableResult
    public func assertHasCount(
        _ count: Int,
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) matches \(count) elements",
            condition: { $0.count == count },
            timeout: timeout,
            message() ?? "\(self) should return \(count) results but returned \(self.count)",
            file: file,
            line: line
        )
        return self
    }

    /// Evaluates the query and asserts that it matches number of elements in given `range`.
    ///
    /// - Parameters:
    ///   - range: The expected range of elements that should match the query.
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element query.
    @discardableResult
    public func assertHasCount(
        _ range: some RangeExpression<Int>,
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) matches \(range) elements",
            condition: { range.contains($0.count) },
            timeout: timeout,
            message() ?? "\(self) should return number of results in range \(range) but returned \(self.count)",
            file: file,
            line: line
        )
        return self
    }

    /// Evaluates the query and asserts that there are no matching elements.
    ///
    /// - Parameters:
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element query.
    @discardableResult
    public func assertNotExists(
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
         file: StaticString = #file,
         line: UInt = #line
    ) -> Self {
        return assertHasCount(
            0,
            timeout: timeout,
            message() ?? "\(self) should return no results but returned \(self.count)",
            file: file,
            line: line
        )
    }

    /// Evaluates the query and asserts that there is at least one matching element.
    ///
    /// - Parameters:
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element query.
    @discardableResult
    public func assertExists(
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        return assertHasCount(
            1...,
            timeout: timeout,
            message() ?? "\(self) should return at least one result but returned \(self.count)",
            file: file,
            line: line
        )
    }

    /// Evaluates the query and verifies matched elements in order.
    ///
    /// Inside of the assertion closure you should use provided argument to access child elements. It is expected that
    /// you will call that argument exactly as many times as there are matched child elements. If that count doesn't match
    /// the assertion will fail.
    ///
    /// # Example
    ///
    /// The following code will match all static texts currently visible in the app and verify that there are exactly 2 of them.
    /// The first matched static text will be asserted to have label "One" and the second static text will be asserted to have label "Two".
    /// If there is a different number of static texts, or one of the static text has incorrect label an assertion will fail.
    ///
    /// ```swift
    ///  XCUIApplication().staticTexts.assertMatchedElements { element in
    ///     element().assertHasLabel("One")
    ///     element().assertHasLabel("Two")
    /// }
    /// ```
    ///
    /// - Parameter perform: Closure providing access to matched elements in order.
    ///   Each time argument received by this closure is invoked a new element will be returned.
    /// - Returns: Unmodified UI element query.
    @discardableResult
    public func assertMatchedElements(perform: (_ element: () -> XCUIElement) -> Void) -> Self {
        XCTContext.runActivity(named: "Assert matched elements of \(self)") { _ in
            var currentIndex = 0
            perform({
                defer { currentIndex += 1 }
                return self[currentIndex]
            })
            assertHasCount(currentIndex)
        }
        return self
    }
}
