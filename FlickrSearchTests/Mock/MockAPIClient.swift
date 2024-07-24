//
//  MockAPIClient.swift
//  FlickrSearchTests
//
//  Created by Dheeraj Neelam on 7/23/24.
//

import Foundation
@testable import FlickrSearch

final class MockAPIClient: APIClientProtocol {
    var fetchPhotosFeedError: Error?
    var fetchPhotosFeedReturnValue: FlickrModel?
    
    func fetchPhotos(for query: String) async throws -> FlickrModel {
        if let fetchPhotosFeedError {
            throw fetchPhotosFeedError
        }
        return fetchPhotosFeedReturnValue!
    }
}
