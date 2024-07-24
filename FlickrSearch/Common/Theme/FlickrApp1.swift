//
//  FlickrApp1.swift
//  FlickrSearch
//
//  Created by Dheeraj Neelam on 7/23/24.
//

import SwiftUI

struct FlickrApp1: DDMSThemeProvider {
    static let shared = FlickrApp1()
    init() {}
    let light: DDMSTheme = FlickrApp1LightTheme.shared
    let dark: DDMSTheme  = FlickrApp1DarkTheme.shared
}

class FlickrApp1DarkTheme: DDMSTheme {
    static let shared = FlickrApp1DarkTheme()
    let isDark = true
    let customColor: ColorTokens = FlickrApp1DarkSizeTokens()
}

class FlickrApp1LightTheme: DDMSTheme {
    static let shared = FlickrApp1LightTheme()
    let isDark = false
    let customColor: ColorTokens = FlickrApp1LightSizeTokens()
}

struct FlickrApp1LightSizeTokens: ColorTokens, Equatable {
    init() {}
    @inlinable var primaryTextColor: Color { Color.black }
}

struct FlickrApp1DarkSizeTokens: ColorTokens, Equatable {
    init() {}
    @inlinable var primaryTextColor: Color { Color.white }
}
