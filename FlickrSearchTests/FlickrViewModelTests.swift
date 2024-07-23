//
//  FlickrViewModelTests.swift
//  FlickrSearchTests
//
//  Created by LZU4481 on 7/23/24.
//

import XCTest
@testable import FlickrSearch

final class FlickrViewModelTests: XCTestCase {
    func testSuccessfulPhotosFeed() async {
        let mockAPIClient = MockAPIClient()
        let mockFlicktItem = FlickrItem(title: "Title", link: "Link", media: Media(m: "https://live.staticflickr.com/65535/53875544387_667b38e24d_m.jpg"), dateTaken: "Date taken", description: "Description", published: "2024-07-23T17:47:28Z", author: "Author", authorID: "AuthorId", tags: "Tags")
        let expectedPhotosFeed = FlickrModel(title: "Title", link: "Link", description: "Description", modified: "Modified", generator: "Generator", items: [mockFlicktItem])

        mockAPIClient.fetchPhotosFeedReturnValue = expectedPhotosFeed
        let viewModel = FlickrViewModel(apiClient: mockAPIClient)
        
        XCTAssertEqual(viewModel.status, .inProgress)
        await viewModel.fetchPhotosFeed()
        XCTAssertEqual(viewModel.status, .ready("Title"))
        XCTAssertEqual(viewModel.photosFeed.count, 1)
    }

    func testFailedPhotosFeed() async {
        let mockAPIClient = MockAPIClient()
        mockAPIClient.fetchPhotosFeedError = NSError(domain: "domain", code: -1000)

        let viewModel = FlickrViewModel(apiClient: mockAPIClient)
        
        XCTAssertEqual(viewModel.status, .inProgress)
        await viewModel.fetchPhotosFeed()
        XCTAssertEqual(viewModel.status, .error)
    }
}
