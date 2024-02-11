//
//  XCUIElement+Types.swift
//  
//
//  Created by Łukasz Rutkowski on 11/02/2024.
//

import Foundation
import XCTest

extension XCUIElement.ElementType {
    /// A constant that represent an element type for banner notifications.
    public static let bannerNotification = XCUIElement.ElementType(rawValue: 83)!
}

extension XCUIElement {
    /// A query that matches banner notification elements.
    public var bannerNotifications: XCUIElementQuery {
        descendants(matching: .bannerNotification)
    }
}

extension XCUIElementQuery {
    /// A query that matches banner notification elements.
    public var bannerNotifications: XCUIElementQuery {
        descendants(matching: .bannerNotification)
    }
}
