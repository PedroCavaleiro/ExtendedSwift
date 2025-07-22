//
//  HeightPreferenceKey.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import SwiftUI

/// A preference key that stores the height of a view.
public struct HeightPreferenceKey: @preconcurrency PreferenceKey {
    /// The type of value that this preference key holds, which is a CGFloat representing the height.
    @MainActor public static var defaultValue: CGFloat = 0

    /// A function that combines multiple values into a single value.
    /// - Parameters:
    ///   - value: The current value of the preference key.
    ///   - nextValue: A closure that provides the next value to combine.
    /// - Returns: The combined value, which is the maximum height found.
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
