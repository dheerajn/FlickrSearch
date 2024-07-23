//
//  NavigationLazyView.swift
//  FlickrSearch
//
//  Created by LZU4481 on 7/23/24.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    private let build: () -> Content

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}
