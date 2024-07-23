//
//  FlickrFeedDetailsViewModel.swift
//  FlickrSearch
//
//  Created by LZU4481 on 7/23/24.
//

import Foundation

final class FlickrFeedDetailsViewModel {
    static private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Format of the input date string
        return formatter
    }

    let title: String
    let thumbnail: String
    let author: String
    let height: String
    let width: String
    let readableDate: Date

    init(item: FlickrItem) {
        self.title = item.readableTitle
        self.thumbnail = item.thumbnail
        self.author = item.author
        self.readableDate = FlickrFeedDetailsViewModel.dateFormatter.date(from: item.published) ?? Date()
        
        let flickrRawData = item.description.extractAttributes
        self.height = flickrRawData.height ?? "No height"
        self.width = flickrRawData.width ?? "No width"
        print("viewmode init")
    }
}
