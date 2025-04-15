//
//  ProjectApp.swift
//  Project
//
//  Created by macbook on 14.04.2025.
//

import SwiftUI

@main
struct ProjectApp: App {
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environment(DependencyContainer.resolve(BookListViewModel.self))
                .environment(DependencyContainer.resolve(Coordinator.self))
                .environment(DependencyContainer.resolve(AppState.self))
        }
    }
}
