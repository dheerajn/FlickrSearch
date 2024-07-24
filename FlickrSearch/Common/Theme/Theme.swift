//
//  Theme.swift
//  FlickrSearch
//
//  Created by Dheeraj Neelam on 7/23/24.
//

import SwiftUI

enum Themes: String, CaseIterable {
    case app1, app2
    
    var themeProvider: DDMSThemeProvider {
        switch self {
        case .app1: return FlickrApp1()
        case .app2: return FlickrApp2()
        }
    }
}

struct DDMSThemesKey: EnvironmentKey {
    static let defaultValue: DDMSThemeProvider = FlickrApp1.shared
}

extension EnvironmentValues {
    var theme: DDMSTheme {
        return themes.themeForColorScheme(self.colorScheme)
    }
}

extension EnvironmentValues {
    var themes: DDMSThemeProvider {
        get { self[DDMSThemesKey.self] }
        set { self[DDMSThemesKey.self] = newValue }
    }
}

protocol DDMSThemeProvider {
    var light: DDMSTheme { get }
    var dark:  DDMSTheme { get }
}

extension DDMSThemeProvider {
    func themeForColorScheme(_ colorScheme: ColorScheme) -> DDMSTheme {
        switch colorScheme {
        case .dark:
            return self.dark
        default:
            return self.light
        }
    }
}

protocol DDMSTheme {
    var isDark: Bool { get }
    var customColor: ColorTokens { get }
}

protocol ColorTokens {
    @inlinable var primaryTextColor: Color { get }
}
