//
//  BookListViewModelTests.swift
//  Project
//
//  Created by macbook on 16.04.2025.
//

@testable import Project
import XCTest

class BookListViewModelTests: XCTestCase {
    var viewModel: BookListViewModel!
    var mockRepository: MockBooksRepository!
    var appState: AppState!

    override func setUp() async throws {
        mockRepository = MockBooksRepository()

        await MainActor.run {
            appState = AppState()
            viewModel = BookListViewModel(appState: appState, repository: mockRepository)
        }
    }

    func testFetchBooksSuccess() async throws {
        mockRepository.mockBooks = MockData.mockBooks
        await MainActor.run {
            viewModel.textfieldText = "Test Author"
        }
        await viewModel.fetchBooks()

        await MainActor.run {
            XCTAssertFalse(appState.isLoading)
            XCTAssertEqual(viewModel.books.count, 1)
            XCTAssertEqual(viewModel.books.first?.title, "Test Book")
        }
    }

    func testFetchBooksFailure() async throws {
        mockRepository.mockError = URLError(.notConnectedToInternet)
        await MainActor.run {
            viewModel.textfieldText = "Test Author"
        }
        await viewModel.fetchBooks()

        await MainActor.run {
            XCTAssertFalse(appState.isLoading)
            XCTAssertTrue(viewModel.showError)
            XCTAssertEqual(viewModel.errorMessage, URLError(.notConnectedToInternet).localizedDescription)
        }
    }
}
