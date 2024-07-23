//
//  FlickrFeedDetailsViewModelTests.swift
//  FlickrSearchTests
//
//  Created by LZU4481 on 7/23/24.
//

import XCTest
@testable import FlickrSearch

final class FlickrFeedDetailsViewModelTests: XCTestCase {
    func testRequiredInfo() {
        let mockFlicktItem = FlickrItem(title: "Title", link: "Link", media: Media(m: "https://live.staticflickr.com/65535/53875544387_667b38e24d_m.jpg"), dateTaken: "Date taken", description: "Description", published: "2024-07-23T17:47:28Z", author: "Author", authorID: "AuthorId", tags: "Tags")
        let viewModel = FlickrFeedDetailsViewModel(item: mockFlicktItem)
        
        XCTAssertEqual(viewModel.author, "Author")
        XCTAssertEqual(viewModel.title, "Title")
        XCTAssertEqual(viewModel.thumbnail, "https://live.staticflickr.com/65535/53875544387_667b38e24d_m.jpg")
        XCTAssertEqual(viewModel.height, "No height")
        XCTAssertEqual(viewModel.width, "No width")
    }

    func testTitleWithWhiteSpace() {
        let mockFlicktItem = FlickrItem(title: " ", link: "Link", media: Media(m: "https://live.staticflickr.com/65535/53875544387_667b38e24d_m.jpg"), dateTaken: "Date taken", description: "Description", published: "2024-07-23T17:47:28Z", author: "Author", authorID: "AuthorId", tags: "Tags")
        let viewModel = FlickrFeedDetailsViewModel(item: mockFlicktItem)
        
        XCTAssertEqual(viewModel.title, "No title")
    }

    func testTitleWithEmptySpace() {
        let mockFlicktItem = FlickrItem(title: "", link: "Link", media: Media(m: "https://live.staticflickr.com/65535/53875544387_667b38e24d_m.jpg"), dateTaken: "Date taken", description: "Description", published: "2024-07-23T17:47:28Z", author: "Author", authorID: "AuthorId", tags: "Tags")
        let viewModel = FlickrFeedDetailsViewModel(item: mockFlicktItem)
        
        XCTAssertEqual(viewModel.title, "No title")
    }

    func testHeightAndWidth() {
        let description = """
<p><a href="https://www.flickr.com/people/200579796@N04/">endlessgriefpublishing</a> posted a photo:</p> <p><a href="https://www.flickr.com/photos/200579796@N04/53875769622/" title="Bergen, Norway"><img src="https://live.staticflickr.com/65535/53875769622_ecb0cd33c3_m.jpg" width="192" height="240" alt="Bergen, Norway" /></a></p>
"""
        let mockFlicktItem = FlickrItem(title: "", link: "Link", media: Media(m: "https://live.staticflickr.com/65535/53875544387_667b38e24d_m.jpg"), dateTaken: "Date taken", description: description, published: "2024-07-23T17:47:28Z", author: "Author", authorID: "AuthorId", tags: "Tags")
        let viewModel = FlickrFeedDetailsViewModel(item: mockFlicktItem)
        
        XCTAssertEqual(viewModel.height, "240")
        XCTAssertEqual(viewModel.width, "192")
    }
}
