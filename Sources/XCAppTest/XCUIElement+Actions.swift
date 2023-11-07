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
            assertExists(waitForAppToIdle: true, message() ?? "\(self) should exist to be interactive.", file: file, line: line)
            assertIsInteractive(message(), file: file, line: line)
        }
        return self
    }

    /// Waits for the element to exist, then taps on it.
    ///
    /// - Parameters:
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    @available(tvOS, unavailable)
    public func tapWhenReady(
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        XCTContext.runActivity(named: "Tap \(self) when ready") { _ in
            assertExists(waitForAppToIdle: true, message() ?? "\(self) should exists to tap on it.", file: file, line: line)
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

    #if !os(tvOS)
    /// Taps the element at normalized offset from its origin.
    ///
    /// - Parameter normalizedOffset: The normalized offset.
    /// - Returns: Unmodified UI element.
    @discardableResult
    @available(tvOS, unavailable)
    public func tap(withNormalizedOffset normalizedOffset: CGVector) -> Self {
        self.coordinate(withNormalizedOffset: normalizedOffset).tap()
        return self
    }

    /// Initiates a press-and-hold gesture at `startPoint`, then drags to `endPoint`.
    ///
    /// - Parameters:
    ///   - startPoint: The normalized offset of coordinate in this element from which to start the drag gesture.
    ///   - endPoint: The normalized offset of coordinate in this element to finish the drag gesture over.
    ///   - pressDuration: The duration of the initial press and hold.
    /// - Returns: Unmodified UI element.
    @discardableResult
    @available(tvOS, unavailable)
    public func drag(
        from startPoint: CGVector,
        to endPoint: CGVector,
        pressDuration: TimeInterval = 0
    ) -> Self {
        let startCoordinate = coordinate(withNormalizedOffset: startPoint)
        let endCoordinate = coordinate(withNormalizedOffset: endPoint)
        startCoordinate.press(forDuration: pressDuration, thenDragTo: endCoordinate)
        return self
    }
    
    /// Sends a long press gesture to a hittable point computed for the element at normalized offset from its origin,
    /// holding for the specified duration.
    ///
    /// - Parameters:
    ///   - duration: Duration in seconds.
    ///   - normalizedOffset: The normalized offset.
    /// - Returns: Unmodified UI element.
    @discardableResult
    @available(tvOS, unavailable)
    public func press(forDuration duration: TimeInterval, withNormalizedOffset normalizedOffset: CGVector) -> Self {
        self.coordinate(withNormalizedOffset: normalizedOffset).press(forDuration: duration)
        return self
    }

    /// Waits for the element to exist, then long presses on it, holding for the specified `duration`.
    ///
    /// - Parameters:
    ///   - duration: Duration in seconds.
    ///   - message: An optional description of a failure.
    ///   - file: The file where the failure occurs. The default is the filename of the test case where you call this function.
    ///   - line: The line number where the failure occurs. The default is the line number where you call this function.
    /// - Returns: Unmodified UI element.
    @discardableResult
    @available(tvOS, unavailable)
    public func pressWhenReady(
        forDuration duration: TimeInterval,
        _ message: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        XCTContext.runActivity(named: "Press \(self) for \(duration) seconds when ready") { _ in
            assertExists(waitForAppToIdle: true, message() ?? "\(self) should exists to press on it.", file: file, line: line)
            press(forDuration: duration)
        }
        return self
    }
    #endif
}
