//
//  FlickrSearchUITests.swift
//  FlickrSearchUITests
//
//  Created by Dheeraj Neelam on 7/23/24.
//

import XCTest

final class FlickrSearchUITests: XCTestCase {
    private let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["isRunningUITests"]
    }

    func testPhotosFeedLaunch() {
        mock(requestURL: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=", withResource: "PhotosFeed")
        app.launch()
        XCTAssertTrue(app.staticTexts["Example Photo 1"].exists)
        app.scrollToBottom()
        XCTAssertTrue(app.staticTexts["Example Photo 15"].exists)
    }
}

private extension FlickrSearchUITests {
    func mock(requestURL: String, withResource: String) {
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: withResource, ofType: "json") {
            do {
                let data: String
                if #available(iOS 16.0, *) {
                    data = try String(contentsOf: URL(filePath: path))
                } else {
                    data = try String(contentsOf: URL(fileURLWithPath: path))
                }
                app.launchEnvironment[requestURL] = data
            } catch {
                XCTFail("Failed to load JSON: \(error.localizedDescription)")
            }
        } else {
            XCTFail("Failed to find JSON")
        }
    }
}
