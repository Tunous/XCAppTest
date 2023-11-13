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
}
