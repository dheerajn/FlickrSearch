//
//  FlickrView.swift
//  FlickrSearch
//
//  Created by Dheeraj Neelam on 7/23/24.
//

import SwiftUI

struct FlickrView: View {
    @State private var viewModel = FlickrViewModel()
    @ScaledMetric private var imageFrame = 50

    @Environment(\.theme) private var theme: DDMSTheme

    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.status {
                case .error:
                    ErrorView()
                    
                case .inProgress:
                    ProgressView()
                    
                case .ready(let title):
                    flickrFeed
                        .accessibilityIdentifier("")
                        .navigationTitle(title)
                }
            }
            .navigationTitle("Flickr Photos Feed")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchedText, prompt: Text("Search for anything"))
            .onChange(of: viewModel.searchedText) { oldValue, newValue in
                if newValue.isEmpty == false {
                    fetchPhotosFeed()
                }
            }
        }
        .task {
            await viewModel.fetchPhotosFeed()
        }
    }
}

// MARK: - Helpers

private extension FlickrView {
    var flickrFeed: some View {
        List(viewModel.photosFeed) { currentFeed in
            NavigationLink {
                NavigationLazyView(FlickrFeedDetailsView(viewModel: FlickrFeedDetailsViewModel(item: currentFeed)))
            } label: {
                HStack {
                    AsyncImageloader(url: URL(string: currentFeed.thumbnail)!) { image in
                        image
                            .resizable()
                            .frame(width: imageFrame, height: imageFrame)
                            .clipShape(Circle())
                    } placeholder: {
                        Image(systemName: "photo.artframe")
                    }

                    VStack(alignment: .leading) {
                        Text(currentFeed.readableTitle)
                            .font(.headline)
                            .foregroundStyle(theme.customColor.primaryTextColor)

                        Text(currentFeed.author)
                            .font(.caption)
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel(Text(currentFeed.accessibilityLabel))
                }
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0) )
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .padding()
    }

    func fetchPhotosFeed() {
        Task {
            await viewModel.fetchPhotosFeed()
        }
    }
}

#Preview {
    NavigationStack {
        FlickrView()
    }
}
