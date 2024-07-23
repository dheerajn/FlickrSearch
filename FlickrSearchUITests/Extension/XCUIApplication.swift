//
//  XCUIApplication.swift
//  FlickrSearchUITests
//
//  Created by LZU4481 on 7/23/24.
//

import XCTest

extension XCUIApplication {
    func scrollToBottom() {
        // This is hardcoded for now but once we have actual data we will calculate based on business logic
        var maxScrolls = 3
        while maxScrolls > 0 {
            swipeUp()
            maxScrolls -= 1
        }
    }
}
