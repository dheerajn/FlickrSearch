//
//  MockURLSession.swift
//  FlickrSearchTests
//
//  Created by LZU4481 on 7/23/24.
//

import Foundation
@testable import FlickrSearch

final class MockURLSession: URLSessionProtocol {
    var nextData: Data?
    var nextError: Error?
    var response: URLResponse?

    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        if let error = nextError {
            throw error
        }
        guard let data = nextData, let response = response else {
            throw URLError(.badServerResponse)
        }
        return (data, response)
    }
}
