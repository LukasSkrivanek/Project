//
//  BooksRepositoryImpl.swift
//  Project
//
//  Created by macbook on 15.04.2025.
//

import Foundation
import SwiftData

protocol BooksRepository: Sendable {
    func fetchBooks(for author: String) async throws -> [Book]
}

final class BooksRepositoryImpl: BooksRepository {
    private let networkManager: NetworkManaging
    private let modelContainer: ModelContainer
    private let cacheActor = CacheActor()

    init(networkManager: NetworkManaging, modelContainer: ModelContainer) {
        self.networkManager = networkManager
        self.modelContainer = modelContainer
    }

    func fetchBooks(for author: String) async throws -> [Book] {
        // First try to get from cache
        if let cached = try? await cacheActor.getCachedBooks(for: author, container: modelContainer),
           !cached.isEmpty
        {
            if await cacheActor.isCacheValid(for: author, container: modelContainer) {
                print("📚 Loading books from CACHE for author: \(author)")
                return cached
            }
        }

        // Fetch from network
        let endpoint = GoogleBooksEndpoint(author: "inauthor:\(author)")
        let fetchedBooksDTO: GoogleBooksResponseDTO = try await networkManager.fetch(from: endpoint, retries: 3)

        guard let items = fetchedBooksDTO.items else {
            return []
        }

        let books = items.map { itemDTO in
            let thumbnail = itemDTO.volumeInfo.secureThumbnailURL ?? ""
            return Book(
                title: itemDTO.volumeInfo.title,
                authors: itemDTO.volumeInfo.authors ?? ["Unknown author"],
                thumbnail: thumbnail,
                description: itemDTO.volumeInfo.description ?? "No description available",
                publishedDate: itemDTO.volumeInfo.publishedDate ?? "Publication date not available",
                infoLink: itemDTO.volumeInfo.infoLink ?? "",
                imageLinks: ImageLinks(thumbnail: thumbnail)
            )
        }

        // Cache the new results
        try? await cacheActor.cacheBooks(books, for: author, container: modelContainer)

        return books
    }
}
