//
//  BookListView.swift
//  Project
//
//  Created by macbook on 15.04.2025.
//

import SwiftUI

struct BookListView: View {
    @Environment(Coordinator.self) var coordinator: Coordinator
    @Environment(BookListViewModel.self) var viewModel: BookListViewModel

    var body: some View {
        VStack(spacing: 16) {
            searchField
            if viewModel.books.isEmpty {
                emptyState
            } else {
                bookList
            }
        }
        .navigationTitle(L10n.searchTitle)
        .alert(isPresented: .twoWay(\.showError, on: viewModel)) {
            Alert(
                title: Text(L10n.errorTitle),
                message: Text(viewModel.errorMessage ?? ""),
                dismissButton: .default(Text(L10n.emptyStateText))
            )
        }
    }

    @ViewBuilder
    private var searchField: some View {
        HStack {
            TextField(L10n.searchPlaceholder, text: .twoWay(\.textfieldText, on: viewModel), onCommit: {
                Task {
                    await viewModel.fetchBooks()
                }
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(.horizontal)
            if viewModel.appState.isLoading {
                ProgressView()
                    .padding(.trailing, 8)
            } else {
                CircleButton(
                    systemName: "magnifyingglass",
                    foregroundColor: .white,
                    backgroundColor: .blue
                ) {
                    Task {
                        await viewModel.fetchBooks()
                    }
                }
                .padding(.trailing, 8)
            }
        }
        .padding(.top, 16)
    }

    @ViewBuilder
    private var emptyState: some View {
        if viewModel.appState.isLoading {
            Spacer()
            ProgressView(L10n.loadingText)
                .font(.headline)
            Spacer()
        } else {
            if #available(iOS 17, *) {
                ContentUnavailableView(
                    L10n.emptyStateText,
                    systemImage: "magnifyingglass",
                    description: Text(L10n.emptyStateDescription)
                )
            } else {
                Text(L10n.emptyStateText)
            }
        }
    }

    private var bookList: some View {
        List(viewModel.books, id: \.hashValue) { book in
            BookRow(book: book)
                .anyButton {
                    coordinator.push(page: .detailPage(book))
                }
                .redacted(reason: viewModel.appState.isLoading ? .placeholder : [])
                .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        }
        .listStyle(InsetListStyle())
    }
}
