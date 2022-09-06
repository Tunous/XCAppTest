import XCTest

extension NSObject {
    func assertPredicate(
        _ predicateFormat: String,
        message: @autoclosure () -> String,
        file: StaticString,
        line: UInt
    ) {
        assertPredicate(NSPredicate(format: predicateFormat), message: message(), file: file, line: line)
    }

    func assertPredicate(
        _ predicate: NSPredicate,
        message: @autoclosure () -> String,
        file: StaticString,
        line: UInt
    ) {
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertTrue(result == .completed, message(), file: file, line: line)
    }
}
