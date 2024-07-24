//
//  ThemeMenu.swift
//  FlickrSearch
//
//  Created by Dheeraj Neelam on 7/23/24.
//

import SwiftUI

struct ThemeMenu: ToolbarContent {
    @Binding var theme: Themes
    @Binding var isDarkMode: Bool
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            Picker("Theme Menu", selection: $theme) {
                ForEach(Themes.allCases, id: \.self) {
                    Text($0.rawValue).font(.title)
                }
            }
            .pickerStyle(.menu)
            .frame(width: 100, height: 30)
            .clipped()

            Picker("ColorScheme Menu", selection: $isDarkMode) {
                Text("Light").tag(false)
                Text("Dark").tag(true)
            }
            .pickerStyle(.segmented)
        }
    }
}
