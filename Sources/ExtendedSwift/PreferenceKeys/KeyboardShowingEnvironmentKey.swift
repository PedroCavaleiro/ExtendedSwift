//
//  KeyboardShowingEnvironmentKey.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import SwiftUI

/// An environment key that indicates whether the keyboard is currently showing.
public struct KeyboardShowingEnvironmentKey: EnvironmentKey {

    /// The default value for the keyboard showing state, which defaults to false.
    public static let defaultValue: Bool = false
}
