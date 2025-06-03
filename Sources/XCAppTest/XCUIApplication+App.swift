import XCTest

extension XCUIApplication {

    // MARK: - Other applications

    /// Proxy for Safari application.
    public static let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
    
    /// Proxy for Springboard.
    @available(macOS, unavailable)
    public static let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

    /// Proxy for Messages application.
    public static let messages = XCUIApplication(bundleIdentifier: "com.apple.MobileSMS")

    /// Proxy for Settings application.
    public static let settings = XCUIApplication(bundleIdentifier: "com.apple.Preferences")

    // MARK: - Checking state

    /// Asserts that the application is currently in foreground.
    ///
    /// - Parameters:
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI application element.
    @discardableResult
    public func assertIsInForeground(
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        XCTContext.runActivity(named: "Assert \(self) is in foreground") { _ in
            XCTAssertTrue(wait(for: .runningForeground, timeout: timeout), message() ?? "\(self) should be in foreground", file: file, line: line)
        }
        return self
    }

    /// Asserts that the application is not currently in foreground.
    ///
    /// - Parameters:
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI application element.
    @discardableResult
    public func assertIsNotInForeground(
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        XCTContext.runActivity(named: "Assert \(self) is NOT in foreground") { _ in
            XCAppTest.assert(
                condition: { $0.state != .runningForeground },
                on: self,
                timeout: timeout,
                message: { message() ?? "\(self) should not be in foreground" },
                file: file,
                line: line
            )
        }
        return self
    }

    /// Asserts that the application's foreground state matches `isInForeground` parameter.
    ///
    /// - Parameters:
    ///   - isInForeground: Whether the app should be in foreground or not.
    ///   - timeout: The number of seconds within which all expectations must be fulfilled.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI application element.
    @discardableResult
    public func assertIsInForeground(
        _ isInForeground: Bool,
        timeout: TimeInterval = XCAppTestConfig.defaultTimeout,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        if isInForeground {
            return assertIsInForeground(timeout: timeout, message(), file: file, line: line)
        }
        return assertIsNotInForeground(timeout: timeout, message(), file: file, line: line)
    }

    // MARK: - Performing actions

    #if (os(iOS) || os(tvOS) || os(watchOS)) && !targetEnvironment(macCatalyst)
    /// Moves the app to background and waits for its state to change to background before continuing.
    ///
    /// - Parameter message: An optional description of a failure.
    /// - Returns: Unmodified UI application element. 
    @discardableResult
    public func moveToBackground(
        _ message: @autoclosure () -> String? = nil
    ) -> Self {
        XCTContext.runActivity(named: "Move \(self) to background") { _ in
            XCUIDevice.shared.press(.home)
            _ = wait(for: .runningBackground, timeout: 3) || wait(for: .runningBackgroundSuspended, timeout: 3)
        }
        return self
    }
    #endif
}
