//
//  OptionalExtension.swift
//  FlickrSearch
//
//  Created by Dheeraj Neelam on 7/23/24.
//

import Foundation

extension Optional where Wrapped == String {
    /// Returns the wrapped value or a default value if the optional is nil or empty.
    func orDefault(_ defaultValue: String) -> String {
        if let value = self, value.isEmptyOrWhitespace == false  {
            return value
        } else {
            return defaultValue
        }
    }
}
