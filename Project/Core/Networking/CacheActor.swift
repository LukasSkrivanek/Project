//
//  CacheActor.swift
//  Project
//
//  Created by macbook on 16.04.2025.
//

import Foundation
import SwiftData

actor CacheActor {
    func getCachedBooks(for author: String, container: ModelContainer) throws -> [Book] {
        let context = ModelContext(container)
        let descriptor = FetchDescriptor<CachedAuthorBooks>(
            predicate: #Predicate { $0.author == author }
        )

        if let cachedAuthorBooks = try context.fetch(descriptor).first {
            return cachedAuthorBooks.books.map { $0.toBook() }
        }
        return []
    }

    func isCacheValid(for author: String, container: ModelContainer) -> Bool {
        let context = ModelContext(container)
        let descriptor = FetchDescriptor<CachedAuthorBooks>(
            predicate: #Predicate { $0.author == author },
            sortBy: [SortDescriptor(\.lastUpdated, order: .reverse)]
        )

        guard let cached = try? context.fetch(descriptor).first else {
            return false
        }

        // Consider cache valid for 1 day
        return cached.lastUpdated.timeIntervalSinceNow > -86400
    }

    func cacheBooks(_ books: [Book], for author: String, container: ModelContainer) throws {
        let context = ModelContext(container)

        let descriptor = FetchDescriptor<CachedAuthorBooks>(
            predicate: #Predicate { $0.author == author }
        )

        for oldCache in try context.fetch(descriptor) {
            context.delete(oldCache)
        }

        let cachedBooks = books.map { book in
            CachedBook(
                id: UUID().uuidString,
                title: book.title,
                authors: book.authors.map { author in CachedAuthor(name: author) },
                thumbnail: book.thumbnail,
                bookDescription: book.description ?? "",
                publishedDate: book.publishedDate,
                infoLink: book.infoLink
            )
        }

        let cachedAuthorBooks = CachedAuthorBooks(
            author: author,
            lastUpdated: Date(),
            books: cachedBooks
        )

        context.insert(cachedAuthorBooks)
        try context.save()
    }
}
