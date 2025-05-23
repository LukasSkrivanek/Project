//
//  AnyButton.swift
//  Project
//
//  Created by macbook on 15.04.2025.
//

import SwiftUI

struct HighlightButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay(
                configuration.isPressed ? Color.accentColor.opacity(0.4) : Color.clear
            )
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

enum ButtonStyleOption {
    case press, highlight, plain
}

extension View {
    @ViewBuilder
    func anyButton(_ option: ButtonStyleOption = .plain, action: @escaping () -> Void) -> some View {
        switch option {
        case .press:
            pressableButton(action: action)
        case .highlight:
            highlightButton(action: action)
        case .plain:
            plainButton(action: action)
        }
    }

    private func plainButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            self
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func pressableButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            self
        }
        .buttonStyle(PressableButtonStyle())
    }

    private func highlightButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            self
        }
        .buttonStyle(HighlightButtonStyle())
    }
}

#Preview {
    VStack {
        Text("Hello")
            .padding()
            .frame(maxWidth: .infinity)
            .anyButton(.highlight, action: {})
            .padding()
        Text("Press me")
            .anyButton(.plain, action: {})
            .padding()
        Text("Pressable Button")
            .anyButton(.press, action: {})
            .padding()
    }
}
