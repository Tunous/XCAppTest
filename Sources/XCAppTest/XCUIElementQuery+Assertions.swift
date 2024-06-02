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
}
