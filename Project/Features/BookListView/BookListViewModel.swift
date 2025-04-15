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

    init(appState: AppState) {
        self.appState = appState
    }

    func fetchBooks() async {
        guard !textfieldText.isEmpty else {
            errorMessage = "Zadejte jméno autora."
            showError = true
            return
        }

        appState.isLoading = true
        let fetchedBooks = MockData.mockBooks
        books = fetchedBooks
        errorMessage = nil
        showError = false

        appState.isLoading = false
    }
}
