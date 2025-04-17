//
//  CircleButton.swift
//  Project
//
//  Created by macbook on 15.04.2025.
//

import SwiftUI

struct CircleButton: View {
    let systemName: String
    let foregroundColor: Color
    let backgroundColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(foregroundColor)
                .padding(10)
                .background(backgroundColor)
                .clipShape(Circle())
        }
    }
}
