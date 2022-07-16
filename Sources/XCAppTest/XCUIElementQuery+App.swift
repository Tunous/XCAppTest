import XCTest

extension XCUIElementQuery {

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
        XCTAssertEqual(self.count, count, message() ?? "Incorrect number of elements matching query \(self)")
        return self
    }
}
