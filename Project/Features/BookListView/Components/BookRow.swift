//
//  BookRow.swift
//  Project
//
//  Created by macbook on 15.04.2025.
//

import SwiftUI

struct BookRow: View {
    let book: Book

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            ImageLoader(imageURL: book.thumbnail)
                .scaledToFill()
                .frame(width: 80, height: 120)
                .cornerRadius(8)
                .shadow(radius: 4)

            VStack(alignment: .leading, spacing: 8) {
                Text(book.title)
                    .font(.headline)
                    .lineLimit(3)
                    .foregroundColor(.primary)

                Text(book.authors.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)

                if let description = book.description {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(4)
                }
            }
            .padding(.vertical, 8)
        }
        .padding(.vertical, 8)
    }
}
