import XCTest

extension XCUIElement {
    func assert(
        condition: @escaping (XCUIElement) -> Bool,
        _ message: @autoclosure () -> String,
        file: StaticString,
        line: UInt
    ) {
        XCAppTest.assert(condition: condition, on: self, message: message, file: file, line: line)
    }
}

extension XCUIElementQuery {
    func assert(
        condition: @escaping (XCUIElementQuery) -> Bool,
        _ message: @autoclosure () -> String,
        file: StaticString,
        line: UInt
    ) {
        XCAppTest.assert(condition: condition, on: self, message: message, file: file, line: line)
    }
}

func assert<T>(condition: @escaping (T) -> Bool, on object: T, message: () -> String, file: StaticString, line: UInt) {
    if condition(object) {
        return
    }
    let predicate = NSPredicate { _, _ in
        return condition(object)
    }
    let expectation = XCTNSPredicateExpectation(predicate: predicate, object: nil)
    let result = XCTWaiter.wait(for: [expectation], timeout: 8)
    XCTAssertTrue(result == .completed, message(), file: file, line: line)
}
