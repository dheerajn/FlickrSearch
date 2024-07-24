//
//  FlickrViewModelTests.swift
//  FlickrSearchTests
//
//  Created by Dheeraj Neelam on 7/23/24.
//

import XCTest
@testable import FlickrSearch

final class FlickrViewModelTests: XCTestCase {
    func testSuccessfulPhotosFeed() async {
        let mockAPIClient = MockAPIClient()
        let mockFlicktItem1 = FlickrItem(title: "Title", link: "Link", media: Media(m: "https://live.staticflickr.com/65535/53875544387_667b38e24d_m.jpg"), dateTaken: "Date taken", description: "Description", published: "2024-07-23T17:47:28Z", author: "Author", authorID: "AuthorId", tags: "Tags")
        let mockFlicktItem2 = FlickrItem(title: "Title 2", link: "Link 2", media: Media(m: "https://live.staticflickr.com/65535/53875544387_667b38e24d_m.jpg"), dateTaken: "Date taken 2", description: "Description 2", published: "2024-07-23T17:47:28Z", author: "Author", authorID: "AuthorId", tags: "human, animal")
        let expectedPhotosFeed = FlickrModel(title: "Title", link: "Link", description: "Description", modified: "Modified", generator: "Generator", items: [mockFlicktItem1, mockFlicktItem2])

        mockAPIClient.fetchPhotosFeedReturnValue = expectedPhotosFeed
        let viewModel = FlickrViewModel(apiClient: mockAPIClient)
        
        XCTAssertEqual(viewModel.status, .inProgress)
        await viewModel.fetchPhotosFeed()
        XCTAssertEqual(viewModel.status, .ready("Title"))
        XCTAssertEqual(viewModel.photosFeed.count, 2, "This is the intial search with no values, so we have to show all the data")
    }

    func testSuccessfulPhotosFeedWithSearchedString() async {
        let mockAPIClient = MockAPIClient()
        let mockFlicktItem1 = FlickrItem(title: "Title", link: "Link", media: Media(m: "https://live.staticflickr.com/65535/53875544387_667b38e24d_m.jpg"), dateTaken: "Date taken", description: "Description", published: "2024-07-23T17:47:28Z", author: "Author", authorID: "AuthorId", tags: "Tags")
        let mockFlicktItem2 = FlickrItem(title: "Title 2", link: "Link 2", media: Media(m: "https://live.staticflickr.com/65535/53875544387_667b38e24d_m.jpg"), dateTaken: "Date taken 2", description: "Description 2", published: "2024-07-23T17:47:28Z", author: "Author", authorID: "AuthorId", tags: "human, animal")
        let expectedPhotosFeed = FlickrModel(title: "Title", link: "Link", description: "Description", modified: "Modified", generator: "Generator", items: [mockFlicktItem1, mockFlicktItem2])

        mockAPIClient.fetchPhotosFeedReturnValue = expectedPhotosFeed
        let viewModel = FlickrViewModel(apiClient: mockAPIClient)
        viewModel.searchedText = "human"

        XCTAssertEqual(viewModel.status, .inProgress)
        await viewModel.fetchPhotosFeed()
        XCTAssertEqual(viewModel.status, .ready("Title"))
        XCTAssertEqual(viewModel.photosFeed.count, 1, "There is only one tag matching the searched string")
    }

    func testSuccessfulPhotosFeedWithMultipleSearchedString() async {
        let mockAPIClient = MockAPIClient()
        let mockFlicktItem1 = FlickrItem(title: "Title", link: "Link", media: Media(m: "https://live.staticflickr.com/65535/53875544387_667b38e24d_m.jpg"), dateTaken: "Date taken", description: "Description", published: "2024-07-23T17:47:28Z", author: "Author", authorID: "AuthorId", tags: "Tags")
        let mockFlicktItem2 = FlickrItem(title: "Title 2", link: "Link 2", media: Media(m: "https://live.staticflickr.com/65535/53875544387_667b38e24d_m.jpg"), dateTaken: "Date taken 2", description: "Description 2", published: "2024-07-23T17:47:28Z", author: "Author", authorID: "AuthorId", tags: "human, animal")
        let mockFlicktItem3 = FlickrItem(title: "Title 2", link: "Link 2", media: Media(m: "https://live.staticflickr.com/65535/53875544387_667b38e24d_m.jpg"), dateTaken: "Date taken 2", description: "Description 2", published: "2024-07-23T17:47:28Z", author: "Author", authorID: "AuthorId", tags: "animal, bird")

        let expectedPhotosFeed = FlickrModel(title: "Title", link: "Link", description: "Description", modified: "Modified", generator: "Generator", items: [mockFlicktItem1, mockFlicktItem2, mockFlicktItem3])

        mockAPIClient.fetchPhotosFeedReturnValue = expectedPhotosFeed
        let viewModel = FlickrViewModel(apiClient: mockAPIClient)
        viewModel.searchedText = "human, bird"

        XCTAssertEqual(viewModel.status, .inProgress)
        await viewModel.fetchPhotosFeed()
        XCTAssertEqual(viewModel.status, .ready("Title"))
        XCTAssertEqual(viewModel.photosFeed.count, 2, "There are two tags matching the searched string")
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
