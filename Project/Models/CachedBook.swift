import SwiftData
import Foundation

@Model
final class CachedBook {
    let id: String
    let title: String
    let authors: [String]
    let thumbnail: String
    let bookDescription: String
    let publishedDate: String
    let infoLink: String
    
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
            imageLinks: [ImageLinks(thumbnail: thumbnail)]
        )
    }
}

@Model
final class CachedAuthorBooks {
    let author: String
    let lastUpdated: Date
    @Relationship(deleteRule: .cascade) var books: [CachedBook]
    
    init(author: String, lastUpdated: Date, books: [CachedBook]) {
        self.author = author
        self.lastUpdated = lastUpdated
        self.books = books
    }
}