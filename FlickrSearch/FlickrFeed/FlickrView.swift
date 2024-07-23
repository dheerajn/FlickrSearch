//
//  FlickrView.swift
//  FlickrSearch
//
//  Created by LZU4481 on 7/23/24.
//

import SwiftUI

struct FlickrView: View {
    @State var viewModel = FlickrViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    FlickrView()
}

@Observable
class FlickrViewModel {
    enum FlickrAPIStatus {
        case inProgress
        case ready
        case error
    }

    private let apiClient: APIClientProtocol
    
    var status = FlickrAPIStatus.inProgress
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchDesserts() async {
        do {
            let photos = try await apiClient.fetchPhotos(for: "forest")
            await MainActor.run {
                print(photos)
                status = .ready
            }
        } catch {
            await MainActor.run {
                status = .error
            }
        }
    }
}
