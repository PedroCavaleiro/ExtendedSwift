//
//  KeyboardVisibility.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//


import SwiftUI

@available(iOS 14.0, *)
public struct KeyboardVisibility: ViewModifier {
    @StateObject private var keyboardMonitor = KeyboardMonitor()
    
    /// Monitors the keyboard state
    ///
    /// - Returns: The modified view
    public func body(content: Content) -> some View {
        content
            .environment(\.keyboardShowing, keyboardMonitor.isKeyboardShowing)
    }
}
