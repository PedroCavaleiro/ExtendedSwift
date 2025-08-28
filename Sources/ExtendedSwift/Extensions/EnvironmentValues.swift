//
//  EnvironmentValues.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import SwiftUI

/// A custom environment key to track whether the keyboard is currently showing.
extension EnvironmentValues {
    /// A key to store the keyboard showing state in the environment.
    public var keyboardShowing: Bool {
        get { self[KeyboardShowingEnvironmentKey.self] }
        set { self[KeyboardShowingEnvironmentKey.self] = newValue }
    }
}
