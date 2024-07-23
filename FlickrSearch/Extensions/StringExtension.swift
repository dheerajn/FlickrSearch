//
//  StringExtension.swift
//  FlickrSearch
//
//  Created by LZU4481 on 7/23/24.
//

import Foundation

extension String {
    typealias FlickrRawText = (title: String?, width: String?, height: String?)
    var extractAttributes: FlickrRawText {
        let htmlString = self
        var title: String?
        var width: String?
        var height: String?
        
        do {
            let regex = try NSRegularExpression(pattern: #"title=\"([^"]*)\".*?width=\"([^"]*)\".*?height=\"([^"]*)\""#, options: [])
            if let match = regex.firstMatch(in: htmlString, options: [], range: NSRange(location: 0, length: htmlString.utf16.count)) {
                if let titleRange = Range(match.range(at: 1), in: htmlString) {
                    title = String(htmlString[titleRange])
                }
                if let widthRange = Range(match.range(at: 2), in: htmlString) {
                    width = String(htmlString[widthRange])
                }
                if let heightRange = Range(match.range(at: 3), in: htmlString) {
                    height = String(htmlString[heightRange])
                }
            }
        } catch {
            print("Error: \(error)")
        }
        
        return (title, width, height)
    }
}

extension String {
    var isEmptyOrWhitespace: Bool {
        if self.isEmpty {
            return true
        }
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == ""
    }
}
