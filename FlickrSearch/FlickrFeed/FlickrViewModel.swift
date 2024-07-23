//
//  FlickrViewModel.swift
//  FlickrSearch
//
//  Created by LZU4481 on 7/23/24.
//

import SwiftUI

@Observable
final class FlickrViewModel {
    enum FlickrAPIStatus: Equatable {
        case inProgress
        case ready(String)
        case error
        
        static func ==(lhs: FlickrAPIStatus, rhs: FlickrAPIStatus) -> Bool {
            switch (lhs, rhs) {
            case (.inProgress, .inProgress):
                return true
            case let (.ready(lhsString), .ready(rhsString)):
                return lhsString == rhsString
            case (.error, .error):
                return true
            default:
                return false
            }
        }
    }

    private let apiClient: APIClientProtocol
    
    var status = FlickrAPIStatus.inProgress
    var photosFeed = [FlickrItem]()
    var searchedText = ""

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchPhotosFeed() async {
        do {
            // I checked if the `searchedText` is ok to have spaces or not and we are getting responses so I did not add any validation logic
            let feed = try await apiClient.fetchPhotos(for: searchedText)
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.photosFeed = feed.items
                self.status = .ready(feed.title)
            }
        } catch {
            await MainActor.run {
                status = .error
            }
        }
    }
}
