//
//  AppPages.swift
//  Project
//
//  Created by macbook on 15.04.2025.
//

import Foundation

enum AppPages: Hashable {
    case searchPage
}

enum Sheet: String, Identifiable {
    var id: String {
        rawValue
    }

    case zero
}

enum FullScreenCover: String, Identifiable {
    var id: String {
        rawValue
    }

    case zero
}
