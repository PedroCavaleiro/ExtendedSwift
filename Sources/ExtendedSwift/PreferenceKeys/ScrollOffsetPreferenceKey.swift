//
//  ScrollOffsetPreferenceKey.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import SwiftUI

/// A preference key that stores the scroll offset of a view.
/// This key is used to track the vertical scroll position of a view, allowing other views to respond to changes in the scroll position.
public struct ScrollOffsetPreferenceKey: @preconcurrency PreferenceKey {

    /// The type of value that this preference key holds, which is a CGFloat representing the scroll offset.
    @MainActor public static var defaultValue: CGFloat = 0

    /// A function that combines multiple values into a single value.
    /// - Parameters:
    ///   - value: The current value of the preference key.
    ///   - nextValue: A closure that provides the next value to combine.
    /// - Returns: The combined value, which is the maximum scroll offset found.
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

