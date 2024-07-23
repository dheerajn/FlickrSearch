//
//  APIClientTests.swift
//  FlickrSearchTests
//
//  Created by LZU4481 on 7/23/24.
//

import XCTest
@testable import FlickrSearch
import Foundation

final class APIClientTests: XCTestCase {
    func testFetchPhotosSuccess() async throws {
        let mockSession = MockURLSession()
        let apiClient = APIClient(urlSession: mockSession)
        let mockFlicktItem = FlickrItem(title: "Title", link: "Link", media: Media(m: "https://live.staticflickr.com/65535/53875544387_667b38e24d_m.jpg"), dateTaken: "Date taken", description: "Description", published: "2024-07-23T17:47:28Z", author: "Author", authorID: "AuthorId", tags: "Tags")
        let expectedPhotosFeed = FlickrModel(title: "Title", link: "Link", description: "Description", modified: "Modified", generator: "Generator", items: [mockFlicktItem])
        let jsonData = try JSONEncoder().encode(expectedPhotosFeed)
        mockSession.nextData = jsonData
        mockSession.response = HTTPURLResponse(url: URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let photoFeed = try await apiClient.fetchPhotos(for: "random string")

        XCTAssertEqual(photoFeed.title, "Title")
        XCTAssertEqual(photoFeed.link, "Link")
        XCTAssertEqual(photoFeed.modified, "Modified")
    }

    func testFetchPhotosFailure() async throws {
        let mockSession = MockURLSession()
        let apiClient = APIClient(urlSession: mockSession)

        mockSession.nextError = URLError(.badServerResponse)

        do {
            _ = try await apiClient.fetchPhotos(for: "random string")
        } catch {
            XCTAssertEqual(error as? URLError, URLError(.badServerResponse))
        }
    }
}
