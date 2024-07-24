//
//  FlickrFeedDetailsViewModel.swift
//  FlickrSearch
//
//  Created by Dheeraj Neelam on 7/23/24.
//

import Foundation

/// ViewModel for handling feed details view
final class FlickrFeedDetailsViewModel {
    let title: String
    let thumbnail: String
    let author: String
    let height: String
    let width: String
    let readableDate: Date
    let accessibilityForImage: String

    init(item: FlickrItem) {
        self.title = item.readableTitle
        self.thumbnail = item.thumbnail
        self.author = item.author
        self.readableDate = Date.dateFormatter.date(from: item.published) ?? Date()
        self.accessibilityForImage = item.accessibilityLabel

        let flickrRawData = item.description.extractFlickrAttributes
        self.height = flickrRawData.height.orDefault("No height")
        self.width = flickrRawData.width.orDefault("No width")
    }
}
