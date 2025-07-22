//
//  KeyboardVisibility.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//


import SwiftUI

/// A view modifier that monitors the keyboard visibility state and provides it to the environment.
@available(iOS 14.0, *)
public struct KeyboardVisibility: ViewModifier {

    /// A state object that monitors the keyboard visibility.
    @StateObject private var keyboardMonitor = KeyboardMonitor()
    
    /// Monitors the keyboard state
    ///
    /// - Returns: The modified view
    public func body(content: Content) -> some View {
        content
            .environment(\.keyboardShowing, keyboardMonitor.isKeyboardShowing)
    }
}
