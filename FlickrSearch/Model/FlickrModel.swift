//
//  FlickrModel.swift
//  FlickrSearch
//
//  Created by LZU4481 on 7/23/24.
//

import Foundation

// MARK: - FlickrModel
struct FlickrModel: Codable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [FlickrItem]
}

// MARK: - Item
struct FlickrItem: Codable, Identifiable {
    let title: String
    let link: String
    let media: Media
    let dateTaken: String
    let description: String
    let published: String
    let author, authorID, tags: String

    var readableTitle: String {
        if title.isEmptyOrWhitespace {
            return "No title"
        }
        return title
    }

    var thumbnail: String {
        media.m
    }

    var id: String {
        title + link
    }

    enum CodingKeys: String, CodingKey {
        case title, link, media
        case dateTaken = "date_taken"
        case description, published, author
        case authorID = "author_id"
        case tags
    }
}

// MARK: - Media
struct Media: Codable {
    let m: String
}
