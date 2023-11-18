import XCTest

extension XCUIElement {
    func assert(
        named assertionName: String,
        condition: @escaping (XCUIElement) -> Bool,
        timeout: TimeInterval,
        _ message: @autoclosure () -> String,
        file: StaticString,
        line: UInt
    ) {
        XCTContext.runActivity(named: assertionName) { _ in
            XCAppTest.assert(condition: condition, on: self, timeout: timeout, message: message, file: file, line: line)
        }
    }
}

extension XCUIElementQuery {
    func assert(
        named assertionName: String,
        condition: @escaping (XCUIElementQuery) -> Bool,
        timeout: TimeInterval,
        _ message: @autoclosure () -> String,
        file: StaticString,
        line: UInt
    ) {
        XCTContext.runActivity(named: assertionName) { _ in
            XCAppTest.assert(condition: condition, on: self, timeout: timeout, message: message, file: file, line: line)
        }
    }
}

func assert<T>(
    condition: @escaping (T) -> Bool,
    on object: T,
    timeout: TimeInterval,
    message: () -> String,
    file: StaticString,
    line: UInt
) {
    if condition(object) {
        return
    }
    let predicate = NSPredicate { _, _ in
        return condition(object)
    }
    let expectation = XCTNSPredicateExpectation(predicate: predicate, object: nil)
    let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
    XCTAssertTrue(result == .completed, message(), file: file, line: line)
}
