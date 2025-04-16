//
//  DependencContainer.swift
//  Project
//
//  Created by macbook on 15.04.2025.
//

import SwiftData
import SwiftUI
import Swinject

@MainActor
class DependencyContainer {
    static let shared = DependencyContainer()

    let container: Container
    let modelContainer: ModelContainer
    private init() {
        let schema = Schema([
            CachedAuthorBooks.self,
            CachedBook.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            modelContainer = try ModelContainer(for: schema, configurations: modelConfiguration)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }

        container = Container()
        container.register(Coordinator.self) { _ in
            Coordinator()
        }.inObjectScope(.container)
        container.register(AppState.self) { _ in
            AppState()
        }.inObjectScope(.container)
        container.register(BookListViewModel.self) { resolve in
            BookListViewModel(
                appState: resolve.resolve(
                    AppState.self
                )!,
                repository: resolve.resolve(
                    BooksRepository.self
                )!
            )
        }.inObjectScope(.container)
        container.register(NetworkManaging.self) { _ in
            NetworkManager()
        }
        .inObjectScope(.container)
        container.register(BooksRepository.self) { resolve in
            BooksRepositoryImpl(
                networkManager: resolve.resolve(
                    NetworkManaging.self
                )!,
                modelContainer: self.modelContainer
            )
        }.inObjectScope(.container)
    }

    static func resolve<T>(_ type: T.Type) -> T {
        guard let dependency = shared.container.resolve(type) else {
            fatalError("Dependency for \(type) not found. Check Swinject registrations.")
        }
        return dependency
    }
}
