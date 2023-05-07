import Foundation
import XCTest

extension XCUIElement {

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
        XCTContext.runActivity(named: "Wait for \(self) to be interactive") { _ in
            assertExists(waitForAppToIdle: true, message() ?? "Element should exist to be interactive.", file: file, line: line)
            assertIsInteractive(message(), file: file, line: line)
        }
        return self
    }

    /// Waits for the element to exist and become interactive, then taps on it.
    ///
    /// - Parameters:
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func tapWhenReady(
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        XCTContext.runActivity(named: "Tap \(self) when ready") { _ in
            waitForInteractivity(message(), file: file, line: line)
            tap()
        }
        return self
    }

    /// Slowly types a string into the element.
    ///
    /// Regular `typeText` function can sometimes miss characters if it goes too fast. This function resolves this issue
    /// by requesting typing character by character. Note that it is much slower than `typeText` and shouldn't be used for long text.
    ///
    /// - Parameters:
    ///   - text: Text to type into the element.
    /// - Returns: Unmodified UI element.
    @discardableResult
    public func slowTypeText(_ text: String) -> Self {
        XCTContext.runActivity(named: "Slow type text \"\(text)\"") { _ in
            for character in text {
                typeText(String(character))
            }
        }
        return self
    }
}
