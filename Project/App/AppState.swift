//
//  AppState.swift
//  Project
//
//  Created by macbook on 15.04.2025.
//

import Observation
import SwiftUI

@Observable @MainActor
final class AppState {
    var isLoading: Bool = false
}
