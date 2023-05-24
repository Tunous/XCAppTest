import XCTest

extension XCUIElementQuery {

    // MARK: - Checking number of elements

    /// Evaluates the query and asserts that it matches `count` number of elements.
    ///
    /// - Parameters:
    ///   - count: The expected number of elements that should match the query.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element query.
    @discardableResult
    public func assertHasCount(
        _ count: Int,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        assert(
            named: "Assert \(self) matches \(count) elements",
            condition: { $0.count == count },
            message() ?? "\(self) should return \(count) results but returned \(self.count)",
            file: file,
            line: line
        )
        return self
    }

    /// Evaluates the query and asserts that there are no matching elements..
    ///
    /// - Parameters:
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element query.
    @discardableResult
    public func assertNotExists(
        _ message: @autoclosure () -> String? = nil,
         file: StaticString = #file,
         line: UInt = #line
    ) -> Self {
        return assertHasCount(0, message() ?? "\(self) should return no results but returned \(self.count)", file: file, line: line)
    }
}
