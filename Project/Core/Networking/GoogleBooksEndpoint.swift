//
//  GoogleBooksEndpoint.swift
//  Project
//
//  Created by macbook on 15.04.2025.
//
// AIzaSyBUpxuqhfdi0NYu_S58ruBoB17YgSjTTfQ
import Foundation

struct GoogleBooksEndpoint: Endpoint {
    var baseURL: URL {
        URL(string: "https://www.googleapis.com/books/v1")!
    }

    var path: String {
        "/volumes"
    }

    var method: HTTPMethod {
        .get
    }

    var headers: [String: String]? {
        nil
    }

    var parameters: [String: Any]? {
        [
            "q": author,
            "langRestrict": "cs",
            "key": "AIzaSyBUpxuqhfdi0NYu_S58ruBoB17YgSjTTfQ",
            "maxResults": 40,
            "orderBy": "relevance",
        ]
    }

    let author: String

    init(author: String) {
        self.author = author
    }
}
