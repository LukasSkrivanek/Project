//
//  Coordinator.swift
//  Project
//
//  Created by macbook on 15.04.2025.
//

import Foundation
import SwiftUI

@Observable @MainActor
final class Coordinator {
    var path: NavigationPath = .init()
    var sheet: Sheet?
    var fullScreenCover: FullScreenCover?

    func push(page: AppPages) {
        path.append(page)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        if !path.isEmpty {
            path.removeLast(path.count)
        }
    }

    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }

    func presentFullScreenCover(_ fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }

    func dismissSheet() {
        sheet = nil
    }

    func dismissCover() {
        fullScreenCover = nil
    }

    @MainActor
    @ViewBuilder
    func build(page: AppPages) -> some View {
        switch page {
        case .searchPage: BookListView()
        case let .detailPage(book): DetailView(book: book)
        }
    }

    @MainActor
    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        switch sheet {
        case .zero: EmptyView()
        }
    }
}
