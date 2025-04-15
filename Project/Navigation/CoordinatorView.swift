//
//  CoordinatorView.swift
//  Project
//
//  Created by macbook on 15.04.2025.
//

import SwiftUI

struct CoordinatorView: View {
    @Environment(Coordinator.self) private var coordinator
    var body: some View {
        NavigationStack(path: .twoWay(\.path, on: coordinator)) {
            coordinator.build(page: .searchPage)
                .navigationDestination(for: AppPages.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: .twoWay(\.sheet, on: coordinator)) { sheet in
                    coordinator.build(sheet: sheet)
                }
        }
    }
}
