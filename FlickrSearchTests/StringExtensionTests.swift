//
//  StringExtensionTests.swift
//  FlickrSearchTests
//
//  Created by LZU4481 on 7/23/24.
//

import XCTest
@testable import FlickrSearch

final class StringExtensionTests: XCTestCase {
    func testEmptyString() {
        XCTAssertTrue("".isEmptyOrWhitespace)
    }
    
    func testWhiteSpaceString() {
        XCTAssertTrue(" ".isEmptyOrWhitespace)
    }

    func testFlickRawText() {
        let description = """
<p><a href="https://www.flickr.com/people/200579796@N04/">endlessgriefpublishing</a> posted a photo:</p> <p><a href="https://www.flickr.com/photos/200579796@N04/53875769622/" title="Bergen, Norway"><img src="https://live.staticflickr.com/65535/53875769622_ecb0cd33c3_m.jpg" width="192" height="240" alt="Bergen, Norway" /></a></p>
"""
        let extractedValues = description.extractAttributes
        XCTAssertEqual(extractedValues.height, "240")
        XCTAssertEqual(extractedValues.title, "Bergen, Norway")
        XCTAssertEqual(extractedValues.width, "192")
    }

    func testFailedFlickRawText() {
        let description = """
<p><a href="https://www.flickr.com/people/200579796@N04/">endlessgriefpublishing</a> posted a photo:</p> <p><a href="https://www.flickr.com/photos/200579796@N04/53875769622/" title="Bergen, Norway"><img src="https://live.staticflickr.com/65535/53875769622_ecb0cd33c3_m.jpg"" ="240" alt="Bergen, Norway" /></a></p>
"""
        let extractedValues = description.extractAttributes
        XCTAssertNil(extractedValues.height)
        XCTAssertNil(extractedValues.width)
    }
}
