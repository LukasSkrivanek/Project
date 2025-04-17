//
//  MockBooksRepository.swift
//  Project
//
//  Created by macbook on 16.04.2025.
//

import Foundation
@testable import Project

final class MockBooksRepository: BooksRepository {
    var mockBooks: [Book] = []
    var mockError: Error?

    func fetchBooks(for _: String) async throws -> [Book] {
        if let mockError {
            throw mockError
        }
        return mockBooks
    }
}
