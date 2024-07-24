//
//  FlickrApp2.swift
//  FlickrSearch
//
//  Created by Dheeraj Neelam on 7/23/24.
//

import SwiftUI

struct FlickrApp2: DDMSThemeProvider {
     static let shared = FlickrApp2()
     init() {}
     let light: DDMSTheme = FlickrApp2LightTheme.shared
     let dark: DDMSTheme  = FlickrApp2DarkTheme.shared
}

class FlickrApp2LightTheme: DDMSTheme {
     static let shared = FlickrApp2LightTheme()
     let isDark = false
     let customColor: ColorTokens = FlickrApp2LightSizeTokens()
}

class FlickrApp2DarkTheme: DDMSTheme {
     static let shared = FlickrApp2DarkTheme()
     let isDark = true
     let customColor: ColorTokens = FlickeApp2DarkSizeTokens()
}


struct FlickrApp2LightSizeTokens: ColorTokens, Equatable {
     init() {}
    @inlinable  var primaryTextColor: Color { Color.red }
}

struct FlickeApp2DarkSizeTokens: ColorTokens, Equatable {
     init() {}
    @inlinable  var primaryTextColor: Color { Color.green }
}
