//
//  BookListViewModel.swift
//  Project
//
//  Created by macbook on 15.04.2025.
//

import Foundation
import Observation

@Observable @MainActor
final class BookListViewModel {
    var books: [Book] = []
    var textfieldText: String = ""
    var errorMessage: String?
    var showError: Bool = false
    let appState: AppState
    let repository: BooksRepository

    init(appState: AppState, repository: BooksRepository) {
        self.appState = appState
        self.repository = repository
    }

    func fetchBooks() async {
        guard !textfieldText.isEmpty else {
            errorMessage = "Zadejte jméno autora."
            showError = true
            return
        }
        do {
            let fetchedBooks = try await repository.fetchBooks(for: textfieldText)
            books = fetchedBooks
            errorMessage = nil
            showError = false
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
        appState.isLoading = false

        appState.isLoading = false
    }
}
