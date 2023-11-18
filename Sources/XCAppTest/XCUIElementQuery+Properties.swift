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
}
