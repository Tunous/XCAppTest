//
//  XCUIElementQuery+Properties.swift
//  
//
//  Created by Łukasz Rutkowski on 13/11/2023.
//

import XCTest

extension XCUIElementQuery {
    /// The last element that matches the query.
    public var lastMatch: XCUIElement {
        element(boundBy: count - 1)
    }

    /// Returns an element that will use the index into the query’s results to determine which underlying accessibility element it is matched with.
    ///
    /// - Parameters:
    ///   - index: The index of element to access.
    public subscript(_ index: Int) -> XCUIElement {
        element(boundBy: index)
    }

    /// Returns the first element that matches the query and satisfies the given `predicate`.
    ///
    /// - Parameters:
    ///    - predicate: A closure that takes a matching query element as its argument and returns a Boolean value indicating whether the element is a match.
    /// - Returns: The first matching element that satisfies `predicate`, or `nil` if there is no element that satisfies `predicate`.
    public func first(where predicate: (XCUIElement) -> Bool) -> XCUIElement? {
        for index in 0..<count {
            let element = self[index]
            if predicate(element) {
                return element
            }
        }
        return nil
    }
}
