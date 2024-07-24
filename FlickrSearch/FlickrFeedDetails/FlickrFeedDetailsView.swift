//
//  FlickrFeedDetailsView.swift
//  FlickrSearch
//
//  Created by Dheeraj Neelam on 7/23/24.
//

import SwiftUI

struct FlickrFeedDetailsView: View {
    let viewModel: FlickrFeedDetailsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    AsyncImageloader(url: URL(string: viewModel.thumbnail)!) { image in
                        image
                            .accessibilityLabel(Text(viewModel.accessibilityForImage))
                    } placeholder: {
                        ProgressView()
                    }
                    Spacer()
                }
                
                LabeledContent("Title", value: viewModel.title)
                LabeledContent("Author", value: viewModel.author)
                LabeledContent("Height", value: viewModel.height)
                LabeledContent("Width", value: viewModel.width)

                LabeledContent {
                    Text(viewModel.readableDate, format: Date.FormatStyle().year().month().day())
                } label: {
                    Text("Published on")
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    FlickrFeedDetailsView(
        viewModel: FlickrFeedDetailsViewModel(
            item: FlickrItem(title: "Title",
                             link: "Link",
                             media: Media(m: "https://live.staticflickr.com/65535/53875544387_667b38e24d_m.jpg"),
                             dateTaken: "Date taken",
                             description: "Description",
                             published: "2024-07-23T17:47:28Z",
                             author: "Author",
                             authorID: "AuthorId",
                             tags: "Tags")
        )
    )
}
