//
//  DateExtension.swift
//  FlickrSearch
//
//  Created by Dheeraj Neelam on 7/23/24.
//

import Foundation

extension Date {
    
    /// Date formatter to read the values
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
}
