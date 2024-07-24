//
//  NavigationLazyView.swift
//  FlickrSearch
//
//  Created by Dheeraj Neelam on 7/23/24.
//

import SwiftUI

/// Loads the view on demand rather than initializing on appear
struct NavigationLazyView<Content: View>: View {
    private let build: () -> Content

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}
