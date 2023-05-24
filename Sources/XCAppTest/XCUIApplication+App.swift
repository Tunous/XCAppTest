import XCTest

extension XCUIApplication {

    // MARK: - Other applications

    /// Proxy for Safari application.
    public static let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")

    // MARK: - Checking state

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
        XCTContext.runActivity(named: "Assert \(self) is in foreground") { _ in
            XCTAssertTrue(wait(for: .runningForeground, timeout: 8), message() ?? "\(self) should be in foreground", file: file, line: line)
        }
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
        XCTContext.runActivity(named: "Assert \(self) is NOT in foreground") { _ in
            XCAppTest.assert(
                condition: { $0.state != .runningForeground },
                on: self,
                message: { message() ?? "\(self) should not be in foreground" },
                file: file,
                line: line
            )
        }
    }

    // MARK: - Performing actions

    /// Moves the app to background and waits for its state to change to background before continuing.
    ///
    /// - Parameter message: An optional description of a failure.
    public func moveToBackground(
        _ message: @autoclosure () -> String? = nil
    ) {
        XCTContext.runActivity(named: "Move \(self) to background") { _ in
            XCUIDevice.shared.press(.home)
            _ = wait(for: .runningBackground, timeout: 3) || wait(for: .runningBackgroundSuspended, timeout: 3)
        }
    }
}
