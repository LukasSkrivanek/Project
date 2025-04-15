//
//  ProjectApp.swift
//  Project
//
//  Created by macbook on 14.04.2025.
//

import SwiftUI

@main
struct ProjectApp: App {
    @State private var coordinator = Coordinator()
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environment(coordinator)
        }
    }
}
