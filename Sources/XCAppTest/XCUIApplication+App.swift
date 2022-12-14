import XCTest

extension XCUIApplication {

    /// Proxy for Safari application.
    public static let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")

    /// Moves the app to background and waits for its state to change to background before continuing.
    ///
    /// - Parameter message: An optional description of a failure.
    public func moveToBackground(
        _ message: @autoclosure () -> String? = nil
    ) {
        XCUIDevice.shared.press(.home)
        _ = wait(for: .runningBackground, timeout: 3) || wait(for: .runningBackgroundSuspended, timeout: 3)
    }

    /// Asserts that the application is currently in foreground.
    ///
    /// - Parameters:
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    public func assertIsInForeground(
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        _ = wait(for: .runningForeground, timeout: 3)
        assertPredicate("\(#keyPath(XCUIApplication.state)) == \(XCUIApplication.State.runningForeground.rawValue)", message: message() ?? "Application should be in foreground", file: file, line: line)
    }

    /// Asserts that the application is not currently in foreground.
    ///
    /// - Parameters:
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    public func assertIsNotInForeground(
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        assertPredicate("\(#keyPath(XCUIApplication.state)) != \(XCUIApplication.State.runningForeground.rawValue)", message: message() ?? "Application should not be in foreground", file: file, line: line)
    }
}
