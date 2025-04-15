//
//  DependencContainer.swift
//  Project
//
//  Created by macbook on 15.04.2025.
//

import SwiftUI
import Swinject

@MainActor
class DependencyContainer {
    static let shared = DependencyContainer()
    let container: Container
    private init() {
        container = Container()
        container.register(Coordinator.self) { _ in
            Coordinator()
        }.inObjectScope(.container)
        container.register(AppState.self) { _ in
            AppState()
        }.inObjectScope(.container)
        container.register(BookListViewModel.self) { resolve in
            BookListViewModel(appState: resolve.resolve(AppState.self)!)
        }.inObjectScope(.container)
    }

    static func resolve<T>(_ type: T.Type) -> T {
        guard let dependency = shared.container.resolve(type) else {
            fatalError("Dependency for \(type) not found. Check Swinject registrations.")
        }
        return dependency
    }
}
