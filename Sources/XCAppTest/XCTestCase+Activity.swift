//
//  XCTestCase+Activity.swift
//  
//
//  Created by Łukasz Rutkowski on 23/03/2024.
//

import Foundation
import XCTest

extension XCTestCase {
    /// Create and run a new activity.
    ///
    /// - Parameters:
    ///   - name: The name of the activity. If not provided will be automatically generated from the function name.
    ///   - function: Name of the function.
    ///   - block: A closure to invoke as the body of the activity.
    /// - Returns: Whatever is returned by block.
    /// - Throws: Whatever is thrown by block.
    @MainActor
    public func run<Result>(
        _ name: String? = nil,
        function: StaticString = #function,
        block: @MainActor () throws -> Result
    ) rethrows -> Result {
        let name = name ?? activityName(from: function)
        return try XCTContext.runActivity(named: name) { _ in
            try block()
        }
    }

    private func activityName(from function: StaticString) -> String {
        let functionName = function.description.prefix(while: { $0 != "(" })
        let sentence = functionName.replacingOccurrences(of: "([A-Z])", with: " $1", options: .regularExpression)
        return sentence.prefix(1).uppercased() + sentence.dropFirst().lowercased()
    }
}
