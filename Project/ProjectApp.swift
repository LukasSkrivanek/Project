//
//  ProjectApp.swift
//  Project
//
//  Created by macbook on 14.04.2025.
//

import SwiftUI

@main
struct ProjectApp: App {
    @State private var coordinator = Coordinator()
    @State private var appState = AppState()
    @State private var viewModel = BookListViewModel(appState: AppState())
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environment(coordinator)
                .environment(appState)
                .environment(viewModel)
        }
    }
}
