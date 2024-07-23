//
//  APIClient.swift
//  FlickrSearch
//
//  Created by LZU4481 on 7/23/24.
//

import Foundation

protocol APIClientProtocol {
    func fetchPhotos(for query: String) async throws -> FlickrModel
}

struct APIClient: APIClientProtocol {
    enum APIClientError: Error {
        case badURL
    }

    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchPhotos(for query: String) async throws -> FlickrModel {
        guard let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(query)") else {
            throw APIClientError.badURL
        }
        let flickrModel: FlickrModel = try await fetchData(from: url, as: FlickrModel.self)
        return flickrModel
    }
}

extension APIClient {
    private func fetchData<T: Decodable>(from url: URL, as type: T.Type) async throws -> T {
        #if DEBUG
        if TestDetector.isRunningUITests {
            var dataToDecode: String?
            TestDetector.mockedRequest.forEach { (key: String, value: String) in
                if url.absoluteString.contains(key) {
                    dataToDecode = value
                }
            }
            if let dataToDecode {
                let decodedData = try JSONDecoder().decode(T.self, from: Data(dataToDecode.utf8))
                return decodedData
            }
        }
        #endif

        let (data, response) = try await urlSession.data(from: url, delegate: nil)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
