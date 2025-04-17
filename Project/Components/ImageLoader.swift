//
//  ImageLoader.swift
//  Project
//
//  Created by macbook on 15.04.2025.
//

import Kingfisher
import SwiftUI

struct ImageLoader: View {
    var imageURL: String
    var apiKey: String = APIKeyManager.shared.apiKey!

    var body: some View {
        let fullImageURL = "\(imageURL)\(apiKey)"
        if let url = URL(string: fullImageURL) {
            KFImage(url)
                .resizable()
                .setProcessor(DefaultImageProcessor())
                .cacheOriginalImage()
                .fade(duration: 0.5)
                .placeholder {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
                .scaledToFit()
                .cornerRadius(8)
                .shadow(radius: 5)
        } else {
            Image(systemName: "book.closed.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
                .cornerRadius(8)
        }
    }
}
