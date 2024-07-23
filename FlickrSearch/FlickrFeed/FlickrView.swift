//
//  FlickrView.swift
//  FlickrSearch
//
//  Created by LZU4481 on 7/23/24.
//

import SwiftUI

struct FlickrView: View {
    @State private var viewModel = FlickrViewModel()
    
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
            .navigationTitle("Desserts")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchedText, prompt: Text("Look for anyting"))
            .onSubmit(of: .search) {
                Task {
                    await viewModel.fetchPhotosFeed()
                }
            }
            .onChange(of: viewModel.searchedText) { oldValue, newValue in
                if newValue.isEmpty == false {
                    Task {
                        await viewModel.fetchPhotosFeed()
                    }
                }
            }
        }
        .task {
            await viewModel.fetchPhotosFeed()
        }
    }
    
    private var flickrFeed: some View {
        List(viewModel.photosFeed) { currentFeed in
            NavigationLink {
                NavigationLazyView(FlickrFeedDetailsView(viewModel: FlickrFeedDetailsViewModel(item: currentFeed)))
            } label: {
                HStack {
                    AsyncImageloader(url: URL(string: currentFeed.thumbnail)!) { image in
                        image
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } placeholder: {
                        Image(systemName: "photo.artframe")
                    }

                    VStack(alignment: .leading) {
                        Text(currentFeed.readableTitle)
                            .font(.headline)
                        
                        Text(currentFeed.author)
                            .font(.caption)
                    }
                }
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0) )
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .padding()
    }
}

#Preview {
    FlickrView()
}
