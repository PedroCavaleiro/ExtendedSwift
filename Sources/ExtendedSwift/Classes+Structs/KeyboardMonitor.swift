//
//  KeyboardMonitor.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//


import SwiftUI
import Combine

@available(macOS 10.15, *)
@available(iOS 13.0, *)
public final class KeyboardMonitor: ObservableObject {
    @Published var isKeyboardShowing: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        #if os(macOS)
        // No action needed for macOS
        #else
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { _ in true }
            .assign(to: \.isKeyboardShowing, on: self)
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in false }
            .assign(to: \.isKeyboardShowing, on: self)
            .store(in: &cancellables)
        #endif
    }
}
