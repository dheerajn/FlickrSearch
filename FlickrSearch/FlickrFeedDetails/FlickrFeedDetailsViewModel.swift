//
//  FlickrFeedDetailsViewModel.swift
//  FlickrSearch
//
//  Created by LZU4481 on 7/23/24.
//

import Foundation

extension Date {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
    
    static var monthAndDayFormatter: DateFormatter {
        let monthDayFormatter = DateFormatter()
        monthDayFormatter.dateFormat = "MMM dd"
        return monthDayFormatter
    }
}

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

        let flickrRawData = item.description.extractAttributes
        self.height = flickrRawData.height.orDefault("No height")
        self.width = flickrRawData.width.orDefault("No width")
    }
}
