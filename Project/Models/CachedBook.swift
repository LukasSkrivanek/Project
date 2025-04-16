//
//  CachedBook.swift
//  Project
//
//  Created by macbook on 16.04.2025.
//

import Foundation
import SwiftData

@Model
final class CachedBook {
    var id: String
    var title: String
    var authors: [String]
    var thumbnail: String
    var bookDescription: String
    var publishedDate: String
    var infoLink: String

    init(id: String, title: String, authors: [String], thumbnail: String, bookDescription: String, publishedDate: String, infoLink: String) {
        self.id = id
        self.title = title
        self.authors = authors
        self.thumbnail = thumbnail
        self.bookDescription = bookDescription
        self.publishedDate = publishedDate
        self.infoLink = infoLink
    }

    func toBook() -> Book {
        return Book(
            title: title,
            authors: authors,
            thumbnail: thumbnail,
            description: bookDescription,
            publishedDate: publishedDate,
            infoLink: infoLink,
            imageLinks: ImageLinks(thumbnail: thumbnail)
        )
    }
}

@Model
final class CachedAuthorBooks {
    var author: String
    var lastUpdated: Date
    @Relationship(deleteRule: .cascade) var books: [CachedBook]

    init(author: String, lastUpdated: Date, books: [CachedBook]) {
        self.author = author
        self.lastUpdated = lastUpdated
        self.books = books
    }
}
