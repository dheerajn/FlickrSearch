//
//  FlickrSearchApp.swift
//  FlickrSearch
//
//  Created by Dheeraj Neelam on 7/23/24.
//

import SwiftUI

@main
struct FlickrSearchApp: App {
    @State private var theme: Themes = .app1
    @State private var isDarkMode: Bool = false

    var body: some Scene {
        WindowGroup {
            FlickrView()
                .environment(\.themes, theme.themeProvider)
                .environment(\.colorScheme, isDarkMode ? .dark : .light)
                .toolbar(content: {
                    ThemeMenu(theme: $theme, isDarkMode: $isDarkMode)
                })
        }
    }
}
