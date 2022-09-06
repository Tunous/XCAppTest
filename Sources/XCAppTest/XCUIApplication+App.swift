import XCTest

extension XCUIApplication {
    /// Moves the app to background and waits for its state to change to background before continuing.
    ///
    /// - Parameter message: An optional description of a failure.
    public func moveToBackground(
        _ message: @autoclosure () -> String? = nil
    ) {
        XCUIDevice.shared.press(.home)
        _ = wait(for: .runningBackground, timeout: 3) || wait(for: .runningBackgroundSuspended, timeout: 3)
    }
}
